module Inquisition
  class Runner
    include Plugin

    attr_reader :issues
    APP_PATH = '.'.freeze

    def self.collection
      @collection ||= []
    end

    def self.call
      new.call
    end

    def initialize
      @issues = []
    end
  end
end
