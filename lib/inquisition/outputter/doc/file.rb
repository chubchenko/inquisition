require 'fileutils'

module Inquisition
  module Outputter
    class Doc
      class File
        DEFAULT_EXTNAME = '.docx'.freeze

        def initialize(output_path = ::Inquisition.configuration.output_path)
          @name = ::Rails.application.class.parent_name.underscore.upcase
          @output_path = output_path
        end

        def path
          @path ||= begin
            ::FileUtils.mkdir_p(output_path)

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
