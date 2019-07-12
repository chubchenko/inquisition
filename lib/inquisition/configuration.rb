require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    CONFIG_FILE_NAME = '.inquisition.yml'.freeze
    ROOT_PATH = Dir.pwd
    DEFAULT_HASH = { 'plugins' => [], 'verbose' => false }.freeze

    def to_h
      config_exist? ? data_config.to_h : DEFAULT_HASH
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
  end
end
