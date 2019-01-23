module Inquisition
  module Core
    class BaseFormatter
      JSON_REGEXP_FORMAT = /{.+}/.freeze
      RESULT_HASH = {
        errors: {
          linterable_name: {
            default: 'default'
          },
          linterable_type: {
            default: 'file',
            file: 'file',
            gem: 'gem'
          },
          line: {
            default: 0
          },
          type: {
            default: 'default'
          }
        },
        error_count: {
          default: 0
        },
        total_files: {
          default: 0
        }
      }.freeze

      def initialize(unparsed_data:, spended_time:)
        @unparsed_data = unparsed_data
        @spended_time = spended_time
        @result_hash = {}
      end

      def call
        prepare_result_hash
        @result_hash
      end

      private

      def prepare_result_hash
        add_errors_key
        add_errors_count_key
        add_total_files_key
        add_spended_time_key
      end

      def add_errors_key
        @result_hash[:errors] = build_errors
      end

      def add_errors_count_key
        @result_hash[:error_count] = build_error_count
      end

      def add_total_files_key
        @result_hash[:total_files] = build_total_files_count
      end

      def add_spended_time_key
        @result_hash[:spended_time] = @spended_time
      end

      def build_total_files_count
        build_errors.map { |error| error[:file] }.uniq.count
      end

      def build_error_count
        build_errors.size
      end

      def linterable_name_default
        RESULT_HASH[:errors][:linterable_name][:default]
      end

      def linterable_type_default
        RESULT_HASH[:errors][:linterable_type][:default]
      end

      def linterable_type_gem
        RESULT_HASH[:errors][:linterable_type][:default]
      end

      def linterable_type_file
        RESULT_HASH[:errors][:linterable_type][:default]
      end

      def line_default
        RESULT_HASH[:errors][:line][:default]
      end

      def type_default
        RESULT_HASH[:errors][:type][:default]
      end

      def type_gem
        RESULT_HASH[:errors][:type][:gem]
      end

      def default_error_count
        RESULT_HASH[:error_count][:default]
      end

      def default_total_files
        RESULT_HASH[:total_files][:default]
      end
    end
  end
end
