module Inquisition
  module Core
    class SingleRunner < BaseRunner
      def call
        track_time { run_auditor }
        format_output
        build_data_preparer
      end

      private

      def track_time
        binding.pry
        @spended_time = Benchmark.measure { yield if block_given? }.real
      end

      def run_auditor
        @auditor_report_result = run_cli(command)
      end

      def format_output
        @formatted_output = formatter.new(unparsed_data: @auditor_report_result, spended_time: @spended_time).call
      end

      def build_data_preparer
        # @preparer = DataPreparer.new(@formatted_output)
      end

      def formatter
        Kernel.const_get(auditor_namespase)::Formatter
      end

      def auditor_namespase
        self.class.name.split('::').tap(&:pop).join('::')
      end

      def run_cli(command)
        Open3.capture3(command).first
      rescue Errno::ENOENT
        ''
      end
    end
  end
end
