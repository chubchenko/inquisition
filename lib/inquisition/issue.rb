module Inquisition
  class Issue
    def initialize(message:, severity:, path:, line:, analyzer:)
      @message = message
      @severity = severity
      @path = path
      @line = line
      @analyzer = analyzer
    end
  end
end
