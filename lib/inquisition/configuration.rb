require 'yaml'
require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    CONFIG_FILE_NAME = '.inquisition.yml'.freeze

    attr_reader :options

    def initialize(path = CONFIG_FILE_NAME)
      @options = YAML.load_file(path) if File.exist?(path)
    end

    def verbose?
      @options&.fetch('verbose') { false }
    end
  end
end
