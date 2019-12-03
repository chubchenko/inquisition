require_relative 'html/template'
require_relative 'documentation/doc_view_helper'

module Inquisition
  module Outputter
    class Doc
      Outputter.declare(self, :stop)

      def initialize(_output); end

      def stop(issues)
        generate_doc(issues)
      end

      def generate_doc(_issues)
        documentation = HTML::Template.new('documentation_word').render(Documentation::DocViewHelper.new)
        File.open(path_to_word_file, 'w') { |file| file.write(documentation) }
      end

      private

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
