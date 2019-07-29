module Inquisition
  class Runner
    attr_reader :issues

    def initialize
      @issues = []
    end

    def self.collection
      @collection ||= []
    end

    def self.inherited(descendant)
      collection.push(descendant)
    end

    def self.call
      new.()
    end

    def self.self_key
      (name.split('::') - %w[Inquisition Runner]).join('_').downcase
    end

    private

    def load_environment
      require "#{Dir.pwd}/config/environment"
    end
  end
end
