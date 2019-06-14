require 'launchy'
require 'tilt/haml'

module Inquisition
  module Core
    module Outputers
      class HtmlOutputer < Core::BaseOutputer
        REPORT_FOLDER_NAME = 'tmp/inquisition'.freeze
        INDEX_PAGE = 'index.html'.freeze
        ASSETS_PATH = [
          'lib/inquisition/generators/html/assets',
          'lib/inquisition/generators/html/images'
        ].freeze
        BASE_ENGINE = Tilt::HamlTemplate
        TEMPLATE_PATH = 'lib/inquisition/generators/html/templates'.freeze

        attr_reader :report_folder, :builded_pages

        def call
          build_pack
          open_front_page
        end

        private

        def build_pack
          create_folder
          copy_assets
          build_pages
          save_pages
        end

        def create_folder
          @report_folder = FileUtils.mkdir_p(File.join(Dir.pwd, REPORT_FOLDER_NAME, Time.now.to_i.to_s)).first
        end

        def copy_assets
          ASSETS_PATH.each do |folder|
            FileUtils.cp_r File.join(Inquisition.root, folder), report_folder
          end
        end

        def build_pages
          @builded_pages = Core::Builders::Html::PagesBuilder.new.call
        end

        def save_pages
          builded_pages.each(&method(:save_builded_page))
        end

        def save_builded_page(page)
          File.open(File.join(report_folder, page_name(page[:name])), 'w') { |file| file.write(page[:content]) }
        end

        def page_name(page)
          "#{page}.html"
        end

        def open_front_page
          Launchy.open(File.join(report_folder, INDEX_PAGE)) do |exception|
            puts "Attempted to open #{INDEX_PAGE} and failed because #{exception}"
          end
        end
      end
    end
  end
end
