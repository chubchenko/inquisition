require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    CONFIG_FILE_NAME = '.inquisition.yml'.freeze
    FOLDER_NAME_CONFIG = 'lib/inquisition/default_config'.freeze
    ROOT_PATH = Dir.pwd
    # DEFAULT_HASH = { 'plugins' => [], 'verbose' => false }.freeze

    def to_h
      config_exist? ? data_config.to_h : create_default_config
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
      YAML.load_file(File.join(ROOT_PATH, FOLDER_NAME_CONFIG, CONFIG_FILE_NAME))
    end

    def create_default_config
      File.open("", 'w')
    end
  end
end
