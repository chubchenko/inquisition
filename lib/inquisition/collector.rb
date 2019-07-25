module Inquisition
  class Collector
    def self.call
      new.()
    end

    def initialize
      @collection = Runner.collection
      @config = Configuration.instance.to_h
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << runner.call if runner_enabled?(runner)
      end.flatten
    end

    private

    def runner_enabled?(runner)
      @config.dig('plugins', runner.self_key, 'enabled')
    end
  end
end
