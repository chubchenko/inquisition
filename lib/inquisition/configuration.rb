require 'yaml'
require 'singleton'

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
