module Inquisition
  class Runner
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

    def load_environment
      require "#{Dir.pwd}/config/environment"
    end
  end
end
