module Inquisition
  class Issue
    COMPARISON_ATTRIBUTES = [
      :message, :severity, :path, :line
    ].freeze

    def initialize(message:, severity:, path:, line:, analyzer:)
      @message = message
      @severity = severity
      @path = path
      @line = line
      @analyzer = analyzer
    end

    def ==(other)
      COMPARISON_ATTRIBUTES.all? do |attribute|
        send(attribute) == other.send(attribute)
      end
    end

    alias eql? ==
  end
end
