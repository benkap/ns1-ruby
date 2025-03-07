require "nsone/api"
require "nsone/transport/net_http"
require "nsone/error"

module NSOne
  class Client

    include NSOne::API

    BASE_URL = "https://api.nsone.net"

    def initialize(api_key, api_version: "v1", base_url: BASE_URL, logger: nil)
      @api_key = api_key
      @base_url = base_url
      @api_version = api_version
      @logger = logger
    end

    private

    def perform_request(method, path, body = nil)
      body = JSON.dump(body) if body.is_a? Hash
      log("[NSOne] > #{method} #{path}")
      log("[NSOne] > #{body}") if body
      response = transport.request(method, path, body)
      log("[NSOne] < #{response.inspect}")
      response
    end

    def log(message)
      @logger && @logger.debug(message)
    end

    def transport
      begin
        @transport ||= NSOne::Transport::NetHttp.new(@base_url, @api_version, @api_key)
      rescue NSOne::Transport::RateLimitExceeded
      end
    end

    def blank?(object)
      object.respond_to?(:empty?) ? !!object.empty? : !object
    end

    def validate_required!(params, *keys)
      raise ArgumentError, "Paramenters must be a hash" unless params.is_a? Hash
      missing = keys.reject { |key| params.has_key?(key) or params.has_key?(key.to_s) }
      if missing.any?
        raise MissingParameter, "Missing key(s): #{missing.join(", ")}"
      end
    end

    # Helper to support `domain` name with or without the zone name.
    # e.g. zone: example.com domain: www will generate domain: www.example.com
    def normalize_names!(zone, domain = "")
      domain.replace(zone) if domain.empty?
      no_dot!(zone, domain)
      domain << ".#{zone}" unless domain.empty? || domain.include?(zone)
    end

    # Removes trailing dot from all Strings given
    def no_dot!(*array)
      array.map {|a| a.chop! if a[/\.$/] != nil}
    end

  end
end
