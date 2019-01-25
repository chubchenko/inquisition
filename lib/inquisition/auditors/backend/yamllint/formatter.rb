module Inquisition
  module Auditors
    module Backend
      module Yamllint
        class Formatter < Core::BaseFormatter
          private

          def build_errors
            @build_errors ||= raw_errors.map(&method(:build_error)).flatten
          end

          def build_total_files_count
            @unparsed_data.split("\n").first.scan(/\d/).first.to_i
          end

          def build_error(error)
            error.map do |file, message|
              {
                linterable_name: file,
                linterable_type: linterable_type_default,
                message: message,
                type: type_default,
                line: line_default
              }
            end
          end

          def raw_errors
            @unparsed_data.split('./').map(&method(:prepare_errors)).flatten.tap(&:pop)
          end

          def prepare_errors(error)
            file, *errors = error.split("\n")
            errors.map { |message| Hash[file, message] }
          end
        end
      end
    end
  end
end
