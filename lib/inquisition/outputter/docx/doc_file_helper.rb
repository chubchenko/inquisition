module Inquisition
  module Outputter
    module Docx
      class DocFileHelper
        def path_to_word_file
          Configuration.instance.output_path + define_file_name
        end

        def define_file_name
          "/#{project_file_name}_#{date_file_name}.docx"
        end

        def project_file_name
          Rails.application.class.parent_name
        end

        def date_file_name
          Time.now.strftime('%d_%m_%Y')
        end
      end
    end
  end
end
