# frozen_string_literal: true

require "net/http"
require "openssl"
require "json"
require "uri"
require "nsone/transport"
require "nsone/response"

module NSOne
  module Transport
    class NetHttp


      def initialize(base_url, api_version, api_key)
        @base_url = base_url
        @api_version = api_version
        @api_key = api_key
      end

      def request(method, path, body = nil)
        if method == "GET" && body
          query = URI.encode_www_form(JSON.parse(body).to_a)
          uri = URI.join(@base_url, "#{@api_version}#{path}?#{query}")
        else
          uri = URI.join(@base_url, "#{@api_version}#{path}")
        end
        Net::HTTP.start(uri.host, uri.port, opts(uri)) do |http|
          response = http.send_request(method, uri, body, headers(body))
          process_response(response, get_rates(response))
        end
      end

      private

      def process_response(response, rates = {})
        body = JSON.parse(response.body)
        case response
        when Net::HTTPTooManyRequests
          raise NSOne::Transport::RateLimitExceeded, "#{response}, #{body}"
        when Net::HTTPOK
          NSOne::Response::Success.new(body, response.code.to_i, rates)
        else
          NSOne::Response::Error.new(body, response.code.to_i, rates)
        end
      rescue JSON::ParserError => e
        raise NSOne::Transport::ResponseParseError, "#{response.code_type} #{response.code} error: #{e}"
      end

      def get_rates(response)
        Hash.new.tap do | h |
          h[:by] = response["x-ratelimit-by"] if response["x-ratelimit-by"]
          h[:remaining] = response["x-ratelimit-remaining"] if response["x-ratelimit-remaining"]
          h[:limit] = response["x-ratelimit-limit"].to_i if response["x-ratelimit-limit"]
          h[:period] = response["x-ratelimit-period"].to_i if response["x-ratelimit-period"]
          h[:rate] = (h[:limit] / h[:period]).to_f if h[:limit] && h[:period]
        end
      end

      def opts(uri)
        if uri.scheme == "https"
          {
            use_ssl: true,
            ssl_mode: OpenSSL::SSL::VERIFY_PEER
          }
        end
      end

      def headers(body)
        extra_headers = body.nil? ? {} : { "Content-Type" => "application/json" }
        default_headers.merge(extra_headers)
      end

      def default_headers
        { "X-NSONE-Key" => @api_key }
      end

    end
  end
end