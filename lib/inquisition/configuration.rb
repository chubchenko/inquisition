require 'singleton'
require 'yaml'

module Inquisition
  class Configuration
    include Singleton

    CONFIG_FILE_NAME = '.inquisition.yml'.freeze
    FOLDER_NAME_CONFIG = 'config'.freeze
    ROOT_PATH = Dir.pwd

    def to_h
      config_exist? ? data_config.to_h : data_default_config
    end

    def verbose?
      to_h['verbose']
    end

    private

    def config_exist?
      Dir.glob(File.join(ROOT_PATH, CONFIG_FILE_NAME)).any?
    end

    def data_config
      YAML.load_file(File.join(ROOT_PATH, CONFIG_FILE_NAME))
    end

    def data_default_config
      YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), FOLDER_NAME_CONFIG, CONFIG_FILE_NAME))
    end
  end
end
