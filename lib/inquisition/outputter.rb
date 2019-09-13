module Inquisition
  module Outputter
    autoload :Progress, 'inquisition/outputter/progress'
    autoload :HTML, 'inquisition/outputter/html'

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

      def remove(outputter_to_remove)
        return deregister(outputter_to_remove) if Loader.collection.key?(outputter_to_remove.class)

        raise ArgumentError, "Outputter #{outputter_to_remove} unknown"
      end

      def prepare_default
        @fanout.prepare_default(self)
      end

      def setup_default
        add('progress') if @collection.empty?
      end

      private

      def find_outputter(outputter_to_use)
        return Outputter::Progress if %w[p progress].include?(outputter_to_use)
        return Outputter::HTML if %w[h html].include?(outputter_to_use)

        raise ArgumentError, "Outputter #{outputter_to_use} unknown"
      end

      def register(outputter)
        @collection << outputter

        @fanout.register_listener(outputter, *Loader.collection.fetch(outputter.class))
      end

      def deregister(outputter_to_remove)
        @collection.delete(outputter_to_remove)
        @fanout.deregister_listener(outputter_to_remove, *Loader.collection.fetch(outputter_to_remove.class))
      end
    end
  end
end
