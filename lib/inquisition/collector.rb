module Inquisition
  class Collector
    class << self
      def invoke
        issues = run(ARGV)

        exit unless issues.empty?
      end

      private

      def run(arguments)
        Options.parse(arguments)

        new.call
      end
    end

    def initialize(collection: Runner.collection)
      @collection = collection.select(&:enabled?)
    end

    def call
      Configuration.instance.fanout.around do |fanout|
        @collection.each_with_object([]) do |runner, memo|
          memo << runner.new.run(fanout)
        end.flatten
      end
    end
  end
end
