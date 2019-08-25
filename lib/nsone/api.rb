# frozen_string_literal: true

Dir[ File.expand_path('../api/*.rb', __FILE__) ].each { |f| require f }

module NSOne
  module API
    HTTP_GET    = "GET"
    HTTP_POST   = "POST"
    HTTP_PUT    = "PUT"
    HTTP_DELETE = "DELETE"

    def self.included(base)
      base.send :include,
        NSOne::API::Zones,
        NSOne::API::Records,
        NSOne::API::Account,
        NSOne::API::Stats,
        NSOne::API::Jobs,
        NSOne::API::Feeds,
        NSOne::API::Networks
    end

  end
end
