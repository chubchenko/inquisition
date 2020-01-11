module Inquisition
  module Outputter
    class Doc
      module TPL
        class DB < Base
          def initialize(issues)
            @issues = issues
          end

          def active_record_doctor
            @active_record_doctor ||= begin
              Template.new('db/active_record_doctor').render(ActiveRecordDoctor.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'db/active_record_doctor'
