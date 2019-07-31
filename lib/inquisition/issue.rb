module Inquisition
  class Issue
    attr_reader :level, :file, :line, :message

    LEVELS = {
      high: 'high',
      medium: 'medium',
      low: 'low'
    }.freeze

    def initialize(level:, file:, line:, runner:, message:)
      raise ArgumentError, 'Incorrect issue level' unless LEVELS.value?(level)

      @level = level
      @line = line
      @runner = runner
      @file = file
      @message = message
    end

    def ==(other)
      other.level == level &&
        other.file == file &&
        other.line == line &&
        other.message == message
    end

    alias eql? ==

    def hash
      level.hash ^ file.hash ^ line.hash ^ message.hash
    end
  end
end
