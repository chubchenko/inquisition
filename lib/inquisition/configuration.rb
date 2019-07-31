require 'yaml'
require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    CONFIG_FILE_NAME = '.inquisition.yml'.freeze
    FOLDER_NAME_CONFIG = 'config'.freeze

    def initialize(path = '.inquisition.yml')
      @options =
        if File.exist?(path)
          YAML.load_file(path)
        else
          data_default_config
        end
    end

    def to_h
      @options
    end

    def verbose?
      @options.fetch('verbose') { false }
    end

    def data_default_config
      YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), FOLDER_NAME_CONFIG, CONFIG_FILE_NAME))
    end
  end
end
