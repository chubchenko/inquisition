module Inquisition
  module Outputter
    autoload :Progress, 'inquisition/outputter/progress'
    autoload :HTML, 'inquisition/outputter/html'
    autoload :Documentation, 'inquisition/outputter/documentation'

    def self.declare(outputter, *events)
      Loader.collection[outputter] = events
    end

    class Loader
      def self.collection
        @collection ||= {}
      end

      attr_reader :fanout, :collection

      def initialize(fanout: Fanout.new)
        @fanout = fanout
        @collection = Set.new
        @default_outputter = 'progress'
      end

      def add(outputter_to_use, output = Inquisition::Configuration.instance.output)
        return register(outputter_to_use) if Loader.collection.key?(outputter_to_use.class)

        outputter_class = find_outputter(outputter_to_use)
        register(outputter_class.new(output))
      end

      def prepare_default
        @fanout.prepare_default(self)
      end

      def setup_default
        add('progress') if @collection.empty?
      end

      private

      OUTPUTTER_TYPES = {
        %w[p progress] => Outputter::Progress,
        %w[h html] => Outputter::HTML,
        %w[doc documentation] => Outputter::Documentation
      }.freeze

      def find_outputter(outputter_to_use)
        OUTPUTTER_TYPES.each { |key, value| return value if key.include?(outputter_to_use) }

        raise ArgumentError, "Outputter #{outputter_to_use} unknown"
      end

      def register(outputter)
        @collection << outputter

        @fanout.register_listener(outputter, *Loader.collection.fetch(outputter.class))
      end
    end
  end
end
