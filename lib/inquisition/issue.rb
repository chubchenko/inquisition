module Inquisition
  class Issue
    LEVELS = {
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

    def to_s
      "#{@level} - #{@file} - #{@line} - #{@message} - #{@runner}"
    end
  end
end
