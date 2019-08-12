module Inquisition
  module Formatters
    module Html
      class IssuesList
        def initialize(collection)
          @issues_list_collection = collection
        end

        def create_erb
          ERB.new(File.read(template_path))
             .result(binding)
        end

        def template_path
          "#{Inquisition.root}/lib/inquisition/formatters/html/templates/issues_list.html.erb"
        end

        def file_path
          "#{Rails.root}/inquisition_report/issues_list.html.erb"
        end
      end
    end
  end
end
