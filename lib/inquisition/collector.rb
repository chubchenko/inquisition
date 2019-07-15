module Inquisition
  class Collector
    def self.call
      new.()
    end

    def initialize
      @collection = Runner.collection
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << runner.call
      end.flatten
    end
  end
end
