module Inquisition
  module Core
    module Runners
      class SingleRunner < BaseRunner
        def call
          track_time { run_auditor }
          format_output
        end

        private

        def track_time
          @spended_time = Benchmark.measure { yield if block_given? }.real
        end

        def run_auditor
          @auditor_report_result = run_cli(command)
        end

        def format_output
          formatter.new(unparsed_data: @auditor_report_result, spended_time: @spended_time).call
        end

        def formatter
          Kernel.const_get(auditor_namespase)::Formatter
        end

        def run_cli(command)
          Open3.capture3(command).first
        rescue Errno::ENOENT
          ''
        end
      end
    end
  end
end
