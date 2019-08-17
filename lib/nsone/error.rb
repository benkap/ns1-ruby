module NSOne
  class Error < StandardError; end
  class MissingParameter < Error; end
  class UnexpectedResponse < Error; end
end
