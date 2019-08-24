# frozen_string_literal: true

module NSOne
  module API
    module Stats

      #
      # Returns current queries per second (QPS) for the account
      #
      # @return [NSOne::Response]
      #
      def qps()
        perform_request(HTTP_GET, "/stats/qps")
      end

      
      #
      # Returns current queries per second (QPS) for a specific zone
      #
      # @param [<Type>] zone <description>
      #
      # @return [NSOne::Response]
      #
      def zone_qps(zone)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        normalize_names!(zone)
        perform_request(HTTP_GET, "/stats/qps/#{zone}")
      end


      #
      # Returns current queries per second (QPS) for a specific record
      #
      # @param [String] zone zone name
      # @param [String] domain record name
      # @param [String] type record type (A, CNAME etc)
      #
      # @return [NSOne::Response]
      #
      def record_qps(zone, domain, type)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "domain cannot be blank" if blank?(domain)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        normalize_names!(zone, domain)
        perform_request(HTTP_GET, "/stats/qps/#{zone}/#{domain}/#{type}")
      end


      #
      # Returns statistics and graphs for the entire account over a given period
      #
      # @param [Hash] params will be used as the request body
      #
      # @option params [String] :period one of `1h`, `24h`, or `30d`
      #
      #   Default: 24h
      #
      # @option params [Boolean] :expand if `true` breaks down stats by zone.
      #
      #   Default: `false`
      #
      # @option params [Boolean] :aggregate if `true` returns aggregated stats across all zones and billing tiers
      #
      #   Default: `false`
      #
      # @return [NSOne::Response]
      #
      def usage(params = {})
        perform_request(HTTP_GET, "/stats/usage", params)
      end


      #
      # Returns statistics and graphs for a given zone over a given period
      #
      # @param [Hash] params will be used as the request body
      # @param [String] zone NSOne zone name
      #
      # @option params [String] :period one of `1h`, `24h`, or `30d`
      #
      #   Default: 24h
      #
      # @option params [Boolean] :expand if `true` breaks down stats by zone.
      #
      #   Default: `false`
      #
      # @option params [Boolean] :aggregate if `true` returns aggregated stats across all zones and billing tiers
      #
      #   Default: `false`
      #
      # @return [NSOne::Response]
      #
      def zone_usage(zone, params = {})
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        normalize_names!(zone)
        perform_request(HTTP_GET, "/stats/usage/#{zone}", params)
      end


      #
      # Returns statistics and graphs for a given record over a given period
      #
      # @param [Hash] params will be used as the request body
      # @param [String] zone zone name
      # @param [String] domain record name
      # @param [String] type record type (A, CNAME etc)
      #
      # @option params [String] :period one of `1h`, `24h`, or `30d`
      #
      #   Default: 24h
      #
      # @option params [Boolean] :expand if `true` breaks down stats by zone.
      #
      #   Default: `false`
      #
      # @option params [Boolean] :aggregate if `true` returns aggregated stats across all zones and billing tiers
      #
      #   Default: `false`
      #
      # @return [NSOne::Response]
      #
      def record_usage(zone, domain, type, params = {})
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "domain cannot be blank" if blank?(domain)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        normalize_names!(zone, domain)
        perform_request(HTTP_GET, "/stats/usage/#{zone}/#{domain}/#{type}", params)
      end


      #
      # Returns statistics and graphs on `NSOne Network` level (Managed/Dedicated)
      #
      # @param [Hash] params will be used as the request body
      #
      # @option params [String] :period one of `1h`, `24h`, or `30d`
      #
      #   Default: 24h
      #
      # @option params [Boolean] :expand if `true` breaks down stats by zone.
      #
      #   Default: `false`
      #
      # @option params [Boolean] :aggregate if `true` returns aggregated stats across all zones and billing tiers
      #
      #   Default: `false`
      #
      # @return [NSOne::Response]
      #
      def network_usage(params = {})
        perform_request(HTTP_GET, "/stats/network/usage", params)
      end


      #
      # Returns total usage (Queries) during `:period` per region/Geo-Location. At the moment NSOne API return the following areas:
      # Europe, North America, Oceania, Africa, Asia
      #
      # @param [Hash] params will be used as the request body
      #
      # @option params [String] :period one of `1h`, `24h`, or `30d`
      #
      #   Default: 24h
      #
      # @option params [Boolean] :expand if `true` breaks down stats by zone.
      #
      #   Default: `false`
      #
      # @option params [Boolean] :aggregate if `true` returns aggregated stats across all zones and billing tiers
      #
      #   Default: `false`
      #
      # @return [NSOne::Response]
      #
      def region_usage(params = {})
        perform_request(HTTP_GET, "/stats/region/usage", params)
      end

    end
  end
end
