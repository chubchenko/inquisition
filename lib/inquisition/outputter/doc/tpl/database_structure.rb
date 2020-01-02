module Inquisition
  module Outputter
    class Doc
      module TPL
        class DatabaseStructure < Base
          def initialize(issues)
            @issues = issues
          end

          def active_record_doctor
            @active_record_doctor ||= begin
              Template.new('database_structure/active_record_doctor').render(ActiveRecordDoctor.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'database_structure/active_record_doctor'
