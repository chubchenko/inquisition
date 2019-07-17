module Inquisition
  class Collector
    def initialize(collection: Analyzer.collection)
      @collection = collection
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << runner.new.call
      end.flatten
    end
  end
end
