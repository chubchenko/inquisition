require 'puredocx'

module Inquisition
  module Outputter
    class Documentation
      def initialize(_output)
        generate_doc
      end

      def generate_doc
        PureDocx.create(Inquisition::Configuration.instance.output_path + define_file_name) do |doc|
          doc.content([
                        doc.text(Rails.root.to_s.split('/').last, size: 40, align: 'center')
                      ])
        end
      end

      private

      def define_file_name
        "/#{project_file_name}_#{date_file_name}.docx"
      end

      def project_file_name
        Rails.root.to_s.split('/').last.tr('-', '_')
      end

      def date_file_name
        Time.now.strftime('%d_%m_%Y')
      end
    end
  end
end
