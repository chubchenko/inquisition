module Inquisition
  class Issue
    attr_reader :level, :file, :line, :message

    LEVELS = {
      high: 'high',
      medium: 'medium',
      low: 'low'
    }.freeze

    COMPARABLE_ATTRIBUTES = %i[level file line message].freeze

    def initialize(level:, file:, line:, runner:, message:)
      raise ArgumentError, 'Incorrect issue level' unless LEVELS.value?(level)

      @level = level
      @line = line
      @runner = runner
      @file = file
      @message = message
    end

    def ==(other)
      COMPARABLE_ATTRIBUTES.all? { |attribute| other.public_send(attribute) == public_send(attribute) }
    end

    alias eql? ==

    def hash
      COMPARABLE_ATTRIBUTES.drop(1).reduce(level.hash) { |memo, attribute| memo ^ attribute.hash }
    end
  end
end
