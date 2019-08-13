require 'fileutils'
require 'inquisition/formatters/html/html_builder'
require 'inquisition/formatters/html/overview_builder'
require 'inquisition/formatters/html/issues_list_builder'

module Inquisition
  module Formatters
    class HtmlFormatter
      def initialize(collection)
        @collection = collection
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
        generators.each do |generator|
          File.open(generator.file_path, 'w+') do |file|
            file.write(generator.render)
          end
        end
      end

      def generators
        [
          Html::IssuesListBuilder.new(@collection),
          Html::OverviewBuilder.new(@collection)
        ]
      end

      def assets_directory
        "#{Inquisition.root}/lib/inquisition/formatters/html/assets"
      end

      def user_report_directory
        "#{Rails.root}/inquisition_report"
      end
    end
  end
end
