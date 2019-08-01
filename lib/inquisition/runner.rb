module Inquisition
  class Runner
    include Plugin

    attr_reader :issues

    def self.call
      new.call
    end

    def self.define_name
      (name.split('::') - %w[Inquisition Runner]).join('_').downcase
    end

    def self.enabled?
      Configuration.instance.options&.dig('plugins', define_name, 'enabled')
    end

    def initialize
      @issues = []
    end
  end
end
