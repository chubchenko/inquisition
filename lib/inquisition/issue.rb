module Inquisition
  class Issue
    LEVELS = {
      high: 'high',
      medium: 'medium',
      low: 'low'
    }.freeze

    def initialize(level:, file:, line:, runner:, message:)
      @level = level
      @line = line
      @runner = runner
      @file = file
      @message = message
    end
  end
end
