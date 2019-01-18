module Inquisition
  module Auditors
    class Runner
      def call
        track_time { run_auditor }
        format_output
        build_data_preparer
      end

      private

      def track_time
        @spended_time = Benchmark.measure { yield if block_given? }.real
      end

      def run_auditor
        @result = run_cli(command)
      end

      def format_output
        @formatted_output = formatter.new(@result, @spended_time).call
      end

      def build_data_preparer
        # @preparer = DataPeparer.new(@formatted_output)
      end

      def run_cli(command)
        Open3.capture3(command).first
      rescue Errno::ENOENT
        ''
      end
    end
  end
end
