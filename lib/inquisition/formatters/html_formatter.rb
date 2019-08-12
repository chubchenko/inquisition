require 'fileutils'
# require 'pathname'

module Inquisition
  module Formatters
    class HtmlFormatter
      def initialize(collection)
        @processed_data = collection
      end

      def call
        create_directories
        copy_assets
        create_files
      end

      private

      def create_directories
        FileUtils.mkdir_p(user_report_directory)
      end

      def copy_assets
        FileUtils.cp_r(assets_directory, user_report_directory)
      end

      def create_files
        File.open(user_report_directory, 'w+') do |file|
          file.write(create_erb.result(binding))
        end
      end

      def create_erb
        ERB.new(File.read("#{Inquisition.root}/lib/inquisition/formatters/templates/breakdowns.html.erb"))
      end

      def assets_directory
        "#{Inquisition.root}/lib/inquisition/formatters/assets"
      end

      def user_report_directory
        "#{Rails.root}/inquisition_report"
      end
    end
  end
end
