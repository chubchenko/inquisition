module Inquisition
  class Issue
    LEVEL_LOW = :low

    def initialize(level:, line:, runner:, file:, message:)
      @level = level
      @line = line
      @runner = runner
      @file = file
      @message = message
    end
  end
end
