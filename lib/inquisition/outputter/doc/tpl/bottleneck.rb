module Inquisition
  module Outputter
    class Doc
      module TPL
        class Bottleneck < Base
          def initialize(issues)
            @issues = issues
          end

          def active_record_doctor
            @active_record_doctor ||= begin
              Template.new('bottleneck/active_record_doctor').render(
                Bottleneck::ActiveRecordDoctor.call(@issues)
              )
            end
          end

          def lol_dba
            @lol_dba ||= begin
              Template.new('bottleneck/lol_dba').render(
                Bottleneck::LolDba.call(@issues)
              )
            end
          end

          def fasterer
            @fasterer ||= begin
              Template.new('bottleneck/fasterer').render(
                Bottleneck::Fasterer.call(@issues)
              )
            end
          end
        end
      end
    end
  end
end

require_relative 'bottleneck/active_record_doctor'
require_relative 'bottleneck/lol_dba'
require_relative 'bottleneck/fasterer'
