# frozen_string_literal: true

module NSOne
  module API
    module Zones

      #
      # Returns all active zones and basic zone configuration details for each
      #
      # @return [NSOne::Response]
      #
      def zones
        perform_request(HTTP_GET, "/zones")
      end

      #
      # Returns a single active Zone and its basic configuration details including all the zones records in a "records" array.
      #
      # @param [required, String] zone zone name
      #
      # @return [NSOne::Response]
      #
      def zone(zone)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        perform_request(HTTP_GET, "/zones/#{zone}")
      end

      #
      # Create a new DNS zone. You must include a JSON body in the request with basic details of the zone.
      # The only required element in the body is zone.
      #
      # @param [required, String] zone zone name
      # @param [Hash] params
      #
      # For all the zone options @see [NSOne API - create-a-new-dns-zone](https://jsapi.apiary.io/apis/ns1api/reference/zones-and-records/zone/create-a-new-dns-zone.html)
      #
      # @return [NSOne::Response]
      #
      def create_zone(zone, params = {})
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        params = params.merge(zone: zone)
        perform_request(HTTP_PUT, "/zones/#{zone}", params)
      end

      #
      # Modifies basic details of a DNS zone.
      # You must include a JSON body in the request, in which you may include ttl (SOA record TTL), refresh, retry, expiry, or nx_ttl values,
      # as in a SOA record. You may not change the zone name or other details.
      #
      # @param [required, String] zone zone name
      # @param [required, Hash] params for all params @see [NSOne API - modify-a-zone](https://jsapi.apiary.io/apis/ns1api/reference/zones-and-records/zone/modify-a-zone.html)
      #
      # @return [NSOne::Response]
      #
      def modify_zone(zone, params = {})
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "params hash must contain valid zone settings" if !params.is_a?(Hash) || params.empty?
        perform_request(HTTP_POST, "/zones/#{zone}", params)
      end

      #
      # Destroys an existing DNS zone and all records in the zone
      #
      # @param [required, String] zone zone name
      #
      # @return [NSOne::Response]
      #
      def delete_zone(zone)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        perform_request(HTTP_DELETE, "/zones/#{zone}")
      end

      #
      # Returns all zones and records that match the given `string`.
      # You can limit the max number of results and you can restrict the type of results to zone, record, or all.
      # Entries in the response without domain/type are zones, and those with domain/type are records.
      #
      # @param [required, String] string search string
      # @param [Hash] params
      #
      # @option params [Integer] :max the max results to return
      # @option params [String] :type to limit the search. valid options are `zone`, `record` or `all`
      #
      # @return [NSOne::Response]
      #
      def search(string, params = {})
        raise NSOne::MissingParameter, "search string cannot be blank" if blank?(string)
        params = params.merge(q: string)
        perform_request(HTTP_GET, "/search", params)
      end

    end
  end
end
