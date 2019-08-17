# frozen_string_literal: true

module NSOne
  module API
    module Jobs

      #
      # Returns the list of all monitoring jobs for the account
      #
      # @return [NSOne::Response]
      #
      def jobs()
        perform_request(HTTP_GET, "/monitoring/jobs")
      end

      #
      # Returns details for a specific monitoring jobs based on its id
      #
      # @param [String] job_id the job ID
      #
      # @return [NSOne::Response]
      #
      def job(job_id)
        raise NSOne::MissingParameter, "job_id cannot be blank" if blank?(job_id)
        perform_request(HTTP_GET, "/monitoring/jobs/#{job_id}")
      end

    end
  end
end
