module Inquisition
  class Runner
    include Plugin

    attr_reader :issues

    def self.call
      new.call
    end

    def initialize
      @issues = []
    end
  end
end
