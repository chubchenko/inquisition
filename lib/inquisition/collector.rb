module Inquisition
  class Collector
    def initialize(collection: Runner.collection)
      @collection = collection
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << runner.new.call if runner.enabled?
      end.flatten
    end
  end
end
