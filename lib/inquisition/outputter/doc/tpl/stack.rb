module Inquisition
  module Outputter
    class Doc
      module TPL
        class Stack < Base
          def ruby_version
            RUBY_VERSION
          end

          def rails_version
            Rails.version
          end

          def db
            @db ||= begin
              OpenStruct.new(
                adapter_name: ::ActiveRecord::Base.connection.adapter_name
              )
            end
          end

          def jobs
            @jobs ||= begin
              Template.new('stack/jobs').render(Stack::Jobs.new)
            end
          end

          def exception
            @exception ||= begin
              Template.new('stack/exception').render(
                Exception.new
              )
            end
          end

          def instrumentation
            @instrumentation ||= begin
              Template.new('stack/instrumentation').render(
                Instrumentation.new
              )
            end
          end
        end
      end
    end
  end
end

require_relative 'stack/collector'
require_relative 'stack/jobs'
require_relative 'stack/exception'
require_relative 'stack/instrumentation'
