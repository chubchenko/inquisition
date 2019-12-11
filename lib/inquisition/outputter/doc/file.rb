require 'fileutils'

module Inquisition
  module Outputter
    class Doc
      class File
        DEFAULT_EXTNAME = '.docx'.freeze

        def initialize
          @name = ::Rails.application.class.parent_name.underscore.upcase
        end

        def path
          @path ||= begin
            ::FileUtils.mkdir_p(::Inquisition::Configuration.instance.output_path)

            ::Pathname.new(
              ::File.join(::Inquisition::Configuration.instance.output_path, name + DEFAULT_EXTNAME)
            )
          end
        end

        private

        attr_reader :name
      end
    end
  end
end
