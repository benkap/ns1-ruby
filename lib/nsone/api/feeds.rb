# frozen_string_literal: true

module NSOne
  module API
    module Feeds

      def source_types()
        types = perform_request(HTTP_GET, "/data/sourcetypes")
        raise NSOne::UnexpectedResponse, "Expected a Hash but responses does not look like a Hash" if ! types.respond_to?(:keys)
        types.keys
      end

      def data_sources()
        perform_request(HTTP_GET, "/data/sources")
      end

      def data_source(data_source_id)
        raise NSOne::MissingParameter, "Data Source ID cannot be blank" if blank?(data_source_id)
        perform_request(HTTP_GET, "/data/sources/#{data_source_id}")
      end

      def create_data_source(params)
        validate_required!(params, :sourcetype, :name, :config)
        perform_request(HTTP_PUT, "/data/sources", params)
      end

      def feeds(data_source_id)
        raise NSOne::MissingParameter, "Data Source ID cannot be blank" if blank?(data_source_id)
        perform_request(HTTP_GET, "/data/feeds/#{data_source_id}")
      end

      def create_data_feed(data_source_id, params)
        raise NSOne::MissingParameter, "Data Source ID cannot be blank" if blank?(data_source_id)
        validate_required!(params, :name, :config)
        perform_request(HTTP_PUT, "/data/feeds/#{data_source_id}", params)
      end

      def delete_data_feed(data_source_id, data_feed_id)
        raise NSOne::MissingParameter, "Data Source ID cannot be blank" if blank?(data_source_id)
        raise NSOne::MissingParameter, "Data Feed ID cannot be blank" if blank?(data_feed_id)
        perform_request(HTTP_DELETE, "/data/feeds/#{data_source_id}/#{data_feed_id}")
      end

      def modify_feed(data_source_id, params)
        raise NSOne::MissingParameter, "Data Source ID cannot be blank" if blank?(data_source_id)
        perform_request(HTTP_POST, "/feed/#{data_source_id}", params)
      end

    end
  end
end
