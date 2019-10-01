require 'yaml'
require 'singleton'
require 'fileutils'

require_relative 'ext/deep_symbolize_keys'

using Inquisition::DeepSymbolizeKeys

require_relative 'ext/deep_symbolize_keys'

using Inquisition::DeepSymbolizeKeys

module Inquisition
  class Configuration
    include Singleton

    DOTFILE = '.inquisition.yml'.freeze

    attr_accessor :output

    def initialize(path = DOTFILE)
      @output = $stdout
      @options =
        if File.exist?(path)
          YAML.load_file(path).deep_symbolize_keys
        else
          {}
        end
    end

    def to_h
      @options
    end

    def verbose?
      @options.fetch(:verbose) { false }
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
