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
      def initialize(base_url, api_key)
        @base_url = base_url
        @api_key = api_key
      end

      def request(method, path, body = nil)
        uri = URI.join(@base_url, path)
        Net::HTTP.start(uri.host, uri.port, opts(uri)) do |http|
          response = http.send_request(method, uri, body, headers(body))
          process_response(response)
        end
      end

      private

      def process_response(response)
        body = JSON.parse(response.body)
        case response
        when Net::HTTPOK
          NSOne::Response::Success.new(body, response.code.to_i)
        else
          NSOne::Response::Error.new(body, response.code.to_i)
        end
      rescue JSON::ParserError
        raise NSOne::Transport::ResponseParseError
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
