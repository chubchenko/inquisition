module Inquisition
  class Collector
    class << self
      def invoke
        status = run(ARGV)

        exit(status) unless status.zero?
      end

      private

      def run(arguments)
        options = Options.parse(arguments).options

        if options.key?(:executor)
          options[:executor].call
        else
          new.call
        end
      end
    end

    def initialize(collection: Runner.collection)
      @collection = collection.select(&:enabled?)
    end

    def call
      success =
        Configuration.instance.fanout.around do |fanout|
          @collection.each_with_object([]) do |runner, memo|
            memo << runner.new.run(fanout)
          end
        end.flatten.empty?

      success ? 0 : 1
    end
  end
end
