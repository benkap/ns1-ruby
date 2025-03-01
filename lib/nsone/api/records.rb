# frozen_string_literal: true

module NSOne
  module API
    module Records

      #
      # Returns full configuration for a DNS record including
      # basic config, answers, regions, filter chain configuration, and all metadata tables and data feeds attached to entities in the record
      #
      # @param [String] zone zone name
      # @param [String] domain record name
      # @param [String] type record type (A, CNAME etc)
      #
      # @return [NSOne::Response]
      #
      def record(zone, domain, type)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        normalize_names!(zone, domain)
        perform_request(HTTP_GET, "/zones/#{zone}/#{domain}/#{type}")
      end

      #
      # <Description>
      #
      # @param [String] zone zone name
      # @param [String] domain record name
      # @param [String] type record type (A, CNAME etc)
      # @param [Hash] params will be used as the request body
      #
      # @option params [String] :zone zone name
      #
      # @option params [String] :domain record name
      #
      # @option params [String] :type record type (A, CNAME etc)
      #
      # @option params [String] :link record name. This is used to create a `linked` record to another record.
      #   When using :link answers array should be empty and filters arrays should be omitted.
      #
      # @option params [Array<Hash>] :answers Array of Hashes with the RDATA values
      #
      # @option params [Array<Hash>] :filters Array of Hashes with settings for record filter-chains rules
      #
      # @option params [Boolean] :use_client_subnet enable EDNS on the record.
      #
      #   Default: `true`
      #
      # @return [NSOne::Response]
      #
      # @example Request body with answers and filter chain arrays. @see [NSOne API](https://ns1.com/api)
      #    {
      #      "zone":"example.com",
      #      "domain":"georegion.example.com",
      #      "type":"A",
      #      "use_client_subnet":false,
      #      "answers":[
      #        {
      #          "answer":[
      #            "1.1.1.1"
      #          ],
      #          "meta":{
      #            "georegion":[
      #              "US-EAST"
      #            ]
      #          }
      #        },
      #        {
      #          "answer":[
      #            "9.9.9.9"
      #          ],
      #          "meta":{
      #            "georegion":[
      #              "US-WEST"
      #            ]
      #          }
      #        }
      #      ],
      #      "filters":[
      #        {
      #          "filter":"geotarget_regional",
      #          "config": {}
      #        },
      #        {
      #          "filter":"select_first_n",
      #          "config":{
      #            "N":1
      #          }
      #        }
      #      ]
      #    }
      #
      #
      def create_record(zone, domain, type, params = {})
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "domain cannot be blank" if blank?(domain)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        validate_required!(params, :answers)
        normalize_names!(zone, domain)
        params = params.merge(zone: zone, domain: domain, type: type)
        perform_request(HTTP_PUT, "/zones/#{zone}/#{domain}/#{type}", params)
      end

      #
      # Modify an existing record. See {NSOne::API::Records#create_record} for available options.
      #
      # @return [NSOne::Response]
      #
      def modify_record(zone, domain, type, params)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "domain cannot be blank" if blank?(domain)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        normalize_names!(zone, domain)
        perform_request(HTTP_POST, "/zones/#{zone}/#{domain}/#{type}", params)
      end

      #
      # Removes an existing record and all associated answers and configuration details
      #
      # @param [String] zone zone name
      # @param [String] domain record name
      # @param [String] type record type (A, CNAME etc)
      #
      # @return [NSOne::Response]
      #
      def delete_record(zone, domain, type)
        raise NSOne::MissingParameter, "zone cannot be blank" if blank?(zone)
        raise NSOne::MissingParameter, "domain cannot be blank" if blank?(domain)
        raise NSOne::MissingParameter, "type cannot be blank" if blank?(type)
        normalize_names!(zone, domain)
        perform_request(HTTP_DELETE, "/zones/#{zone}/#{domain}/#{type}")
      end

    end
  end
end
