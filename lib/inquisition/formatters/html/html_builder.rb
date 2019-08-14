module Inquisition
  module Formatters
    module Html
      class HtmlBuilder
        def initialize(collection)
          @collection = collection
        end

        def render
          ERB.new(File.read(template_path)).result(binding)
        end

        def file_path
          "#{Rails.root}/inquisition_report/#{file_name}"
        end

        private

        def template_path
          "#{Inquisition.root}/lib/inquisition/formatters/html/templates/#{file_name}.erb"
        end

        def file_name
          raise NotImplementedError
        end
      end
    end
  end
end
