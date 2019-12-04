module Inquisition
  module Outputter
    class Xlsx
      class File
        DEFAULT_EXTNAME = '.xlsx'.freeze

        def initialize
          @name = [Rails.application.class.parent.name.underscore, Time.current.strftime('%d_%m_%y')].join('_')
        end

        def path
          @path ||= begin
            ::Pathname.new(
              ::File.join(::Inquisition::Configuration.instance.output_path, name + DEFAULT_EXTNAME)
            )
          end
        end

        def create_folder
          ::FileUtils.mkdir_p(path.dirname)
        end

        private

        attr_reader :name
      end
    end
  end
end
