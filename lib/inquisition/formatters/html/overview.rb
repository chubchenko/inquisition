module Inquisition
  module Formatters
    module Html
      class Overview
        def initialize(collection)
          @overview_collection = collection
        end

        def create_erb
          ERB.new(File.read(template_path))
             .result(binding)
        end

        def template_path
          "#{Inquisition.root}/lib/inquisition/formatters/html/templates/overview.html.erb"
        end

        def file_path
          "#{Rails.root}/inquisition_report/overview.html.erb"
        end
      end
    end
  end
end
