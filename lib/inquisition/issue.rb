module Inquisition
  class Issue
    COMPARISON_ATTRIBUTES = %i[level file line message].freeze

    LEVELS = {
      high: 'high',
      medium: 'medium',
      low: 'low'
    }.freeze

    attr_reader :level, :file, :line, :message

    def initialize(level:, file:, line:, message:, runner:)
      raise ArgumentError, "Unknown level: #{level}" unless LEVELS.value?(level)

      @level = level
      @line = line
      @runner = runner
      @file = file
      @message = message
    end

    def ==(other)
      COMPARISON_ATTRIBUTES.all? do |attribute|
        send(attribute) == other.send(attribute)
      end
    end

    alias eql? ==

    def hash
      COMPARISON_ATTRIBUTES.reduce(0) do |hash, attribute|
        hash ^ send(attribute).hash
      end
    end
  end
end
