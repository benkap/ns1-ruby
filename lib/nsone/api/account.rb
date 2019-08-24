# frozen_string_literal: true

module NSOne
  module API
    module Account

      #
      # Returns the basic contact details associated with your account
      #
      # @return [NSOne::Response]
      #
      def account()
        perform_request(HTTP_GET, "/account/settings")
      end

      #
      # Returns toggles and thresholds used when sending overage warning
      #
      # @return [NSOne::Response]
      #
      def account_overage()
        perform_request(HTTP_GET, "/account/usagewarnings")
      end

      def plan
        perform_request(HTTP_GET, "/account/plan")
      end

      def billataglance
        perform_request(HTTP_GET, "/account/billataglance")
      end

    end
  end
end
