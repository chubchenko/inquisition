module Inquisition
  module Core
    class BaseFormatter
      def initialize(unparsed_data, spended_time)
        @unparsed_data = unparsed_data
        @spended_time = spended_time
        @result_hash = {}
      end

      def call
        prepare_result_hash
      end

      private

      def prepare_result_hash
        add_errors_key
        add_errors_count_key
        add_total_files_key
        add_spended_time_key
      end

      def add_spended_time_key
        @result_hash[:spended_time] = @spended_time
      end
    end
  end
end
