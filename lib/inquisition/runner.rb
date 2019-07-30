module Inquisition
  class Runner
    attr_reader :issues
    APP_PATH = '.'.freeze

    def self.collection
      @collection ||= []
    end

    def self.inherited(descendant)
      collection.push(descendant)
    end

    def self.call
      new.()
    end

    def initialize
      @issues = []
    end

    private

    def load_environment
      require "#{Dir.pwd}/config/environment"
    end
  end
end
