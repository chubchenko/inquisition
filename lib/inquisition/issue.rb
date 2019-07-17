module Inquisition
  class Issue
    ISSUE_LEVELS = {
      high: 'high',
      medium: 'medium',
      low: 'low'
    }.freeze

    def initialize(level:, file:, line:, runner:, message:)
      @level = level
      @file = file
      @line = line
      @message = message
      @runner = runner
    end
  end
end
