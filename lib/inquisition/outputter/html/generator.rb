require 'fileutils'
require_relative 'builder'
require_relative 'overview_builder'
require_relative 'issues_list_builder'

module Inquisition
  module Outputter
    class HTML
      class Generator
        def initialize(collection)
          @collection = collection
        end

        def call
          create_directories
          Rake::Task[:assets_compilation].invoke
          copy_fonts
          create_files
        end

        private

        def create_directories
          FileUtils.mkdir_p(report_directory)
        end

        def copy_fonts
          FileUtils.cp_r(fonts_directory, user_public_directory)
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
            IssuesListBuilder.new(@collection),
            OverviewBuilder.new(@collection)
          ]
        end

        def fonts_directory
          File.join(Inquisition.root, 'assets', 'css', 'vendor', 'fontawesome-free', 'webfonts')
        end

        def user_public_directory
          File.join(Rails.root, 'public', 'inquisition', 'webfonts')
        end

        def report_directory
          File.join(Rails.root, 'inquisition')
        end
      end
    end
  end
end
