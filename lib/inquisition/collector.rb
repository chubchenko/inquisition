module Inquisition
  class Collector
    def initialize(collection: Runner.collection)
      @collection = collection.select(&:enabled?)
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << runner.new.call
      end.flatten
    end
  end
end
