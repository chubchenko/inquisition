require_relative 'html/template'
require_relative 'html/overview'

module Inquisition
  module Outputter
    class Documentation
      def initialize(_output)
        generate_doc
      end

      def generate_doc
        documentation = HTML::Template.new('documentation_word').render(HTML::Overview.new(@collection))
        File.open(create_folder_with_file, 'w') { |file| file.write(documentation) }
      end

      private

      def create_folder_with_file
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
