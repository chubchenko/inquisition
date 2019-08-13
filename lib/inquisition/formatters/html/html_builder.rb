module Inquisition
  module Formatters
    module Html
      class HtmlBuilder
        def initialize(collection)
          @collection = collection
        end

        def render
          create_erb.result(binding)
        end

        def create_erb
          ERB.new(read_file, nil, nil, erb_variable)
        end

        def file_path
          "#{Rails.root}/inquisition_report/#{full_file_name}"
        end

        private

        def erb_variable
          '_erbout'
        end

        def read_file
          File.read(template_path)
        end

        def template_path
          "#{Inquisition.root}/lib/inquisition/formatters/html/templates/#{full_file_name}.erb"
        end

        def full_file_name
          "#{file_name}.html"
        end

        def file_name
          NotImplementedError
        end
      end
    end
  end
end
