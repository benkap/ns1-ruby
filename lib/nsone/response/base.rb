require 'delegate'

module NSOne
  module Response
    class Base < SimpleDelegator
      attr_reader :status, :rates

      def initialize(body, status, rates)
        @status = status
        @rates = rates
        super(body)
      end
    end
  end
end
