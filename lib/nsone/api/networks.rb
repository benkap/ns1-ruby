# frozen_string_literal: true

module NSOne
  module API
    module Networks

      #
      # Returns a lists of all networks for which you may create zones and records.
      #   By default network '0' is always returned as it the NS1 main network.
      #   Customers with dedicated/private DNS service can have more.
      #
      # @example Response
      #  [
      #    {
      #      "network_id"=>0, 
      #      "name"=>"NS1 Managed DNS Network", 
      #      "label"=>"NSONE"
      #    }
      #  ]
      #
      # @return [NSOne::Response]
      #
      def networks()
        perform_request(HTTP_GET, "/networks")
      end

    end
  end
end
