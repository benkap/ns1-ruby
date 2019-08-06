require 'delegate'

module NSOne
  module Response
    class Base < SimpleDelegator
      attr_reader :status

      def initialize(body, status)
        @status = status
        super(body)
      end
    end
  end
end
