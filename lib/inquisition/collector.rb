module Inquisition
  class Collector
    def initialize(collection: Runner.collection)
      @collection = collection
    end

    def call
      @collection.select(&:enabled?).each_with_object([]) do |runner, memo|
        memo << runner.new.call
      end.flatten
    end
  end
end
