require 'yaml'
require 'singleton'
require 'fileutils'

module Inquisition
  class Configuration
    include Singleton

    attr_accessor :output

    def initialize(path = '.inquisition.yml')
      @output = $stdout
      @options =
        if File.exist?(path)
          YAML.load_file(path)
        else
          {}
        end
    end

    def to_h
      @options
    end

    def verbose?
      @options.fetch('verbose') { false }
    end

    def output_path
      @output_path ||= begin
        output_path = File.join(Rails.root, 'inquisition'.freeze)
        FileUtils.mkdir_p(output_path)
        output_path
      end
    end

    def loader
      @loader ||= begin
        Outputter::Loader.new
      end
    end

    def fanout
      @fanout ||= begin
        loader.prepare_default
        loader.fanout
      end
    end

    def collection
      loader.collection
    end
  end
end
