require 'yaml'
require 'singleton'

module Inquisition
  class Configuration
    include Singleton

    def initialize(path = '.inquisition.yml')
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
      false
    end
  end
end
