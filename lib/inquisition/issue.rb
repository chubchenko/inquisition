module Inquisition
  class Issue
    def initialize(level:, line:, runner:)
      @level = level
      @line = line
      @runner = runner
    end
  end
end
