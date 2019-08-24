# frozen_string_literal: true

module NSOne
  module Transport
    class Error < StandardError; end
    class ResponseParseError < Error; end
    class RateLimitExceeded < Error; end
  end
end
