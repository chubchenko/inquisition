module Inquisition
  module Outputter
    class Xlsx
      class File
        DEFAULT_EXTNAME = '.xlsx'.freeze

        def initialize(output_path = ::Inquisition.configuration.output_path)
          @name = ::Rails.application.class.parent_name.underscore.upcase
          @output_path = output_path
        end

        def path
          @path ||= begin
            ::Pathname.new(
              ::File.join(output_path, name + DEFAULT_EXTNAME)
            )
          end
        end

        private

        attr_reader :name, :output_path
      end
    end
  end
end
