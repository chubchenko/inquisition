require 'fileutils'
require 'launchy'

require_relative 'template'
require_relative 'issues'
require_relative 'overview'

module Inquisition
  module Outputter
    class HTML
      class Builder
        def self.call(collection)
          new(collection).call
        end

        def initialize(collection)
          @collection = collection
        end

        def call
          Dir[File.join(::Inquisition.root, 'public/*')].each do |path|
            FileUtils.cp_r(path, assets_output_path)
          end

          File.open(File.join(Inquisition::Configuration.instance.output_path, 'overview.html'), 'wb') do |file|
            file.puts(Template.new('overview').render(Overview.new(@collection)))
          end

          File.open(File.join(Inquisition::Configuration.instance.output_path, 'issues.html'), 'wb') do |file|
            file.puts(Template.new('issues').render(Issues.new(@collection)))
          end

          Launchy.open(File.join(Inquisition::Configuration.instance.output_path, 'overview.html'))
        end

        private

        def assets_output_path
          @assets_output_path ||= begin
            assets_output_path = File.join(Inquisition::Configuration.instance.output_path, 'assets'.freeze)
            FileUtils.mkdir_p(assets_output_path)
            assets_output_path
          end
        end
      end
    end
  end
end
