require_relative 'html/template'
require_relative 'docx/doc_view_helper'
require_relative 'docx/doc_file_helper'

module Inquisition
  module Outputter
    class Doc
      Outputter.declare(self, :stop)

      def initialize(_output); end

      def stop(issues)
        file_helper = Docx::DocFileHelper.new
        documentation = HTML::Template.new('documentation_word').render(Docx::DocViewHelper.new(issues))
        File.open(file_helper.path_to_word_file, 'w') { |file| file.write(documentation) }
      end
    end
  end
end
