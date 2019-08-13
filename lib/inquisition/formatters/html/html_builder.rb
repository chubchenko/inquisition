module Inquisition
  module Formatters
    module Html
      class HtmlBuilder
        def initialize(collection)
          @collection = collection
        end

        def create_erb
          ERB.new(File.read(template_path))
             .result(binding)
        end

        def template_path
          "#{Inquisition.root}/lib/inquisition/formatters/html/templates/#{file_name}"
        end

        def file_path
          "#{Rails.root}/inquisition_report/#{file_name}"
        end

        def file_name
          NotImplementedError
        end
      end
    end
  end
end
