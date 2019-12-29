module Inquisition
  module Outputter
    class Doc
      module TPL
        class BottlenecksDetection < Base
          def initialize(issues)
            @issues = issues
          end

          def active_record_doctor
            @active_record_doctor ||= begin
              Template.new('bottlenecks_detection/active_record_doctor').render(
                BottlenecksDetection::ActiveRecordDoctor.call(@issues)
              )
            end
          end

          def lol_dba
            @lol_dba ||= begin
              Template.new('bottlenecks_detection/lol_dba').render(BottlenecksDetection::LolDba.call(@issues))
            end
          end

          def fasterer
            @fasterer ||= begin
              Template.new('bottlenecks_detection/fasterer').render(BottlenecksDetection::Fasterer.call(@issues))
            end
          end
        end
      end
    end
  end
end

require_relative 'bottlenecks_detection/active_record_doctor'
require_relative 'bottlenecks_detection/lol_dba'
require_relative 'bottlenecks_detection/fasterer'
