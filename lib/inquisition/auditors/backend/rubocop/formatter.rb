module Inquisition
  module Auditors
    module Backend
      module Rubocop
        class Formatter < Core::BaseFormatter
          private

          def add_errors_key
            @result_hash[:errors] = build_errors
          end

          def add_errors_count_key
            @result_hash[:error_count] = data['summary']['offense_count']
          end

          def add_total_files_key
            @result_hash[:total_files] = data['summary']['inspected_file_count']
          end

          def build_errors
            file_with_errors.map(&method(:build_error)).flatten
          end

          def build_error(file)
            file['offenses'].map do |offense|
              {
                file: file['path'],
                type: offense['severity'],
                message: offense['message'],
                line: offense['location']['line']
              }
            end
          end

          def data
            @data ||= JSON.parse(@unparsed_data)
          end

          def file_with_errors
            @file_with_errors ||= data['files'].select { |file| file['offenses'].any? }
          end
        end
      end
    end
  end
end
