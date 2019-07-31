module Inquisition
  class Runner
    include Plugin

    attr_reader :issues

    def initialize
      @issues = []
    end

    def self.collection
      @collection ||= []
    end

    def self.call
      new.call
    end

    def self.self_key
      (name.split('::') - %w[Inquisition Runner]).join('_').downcase
    end

    def self.enabled?
      config.dig('plugins', self_key, 'enabled')
    end

    def self.config
      @config ||= Configuration.instance.to_h
    end
  end
end
