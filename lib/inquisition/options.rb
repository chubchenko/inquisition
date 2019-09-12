require 'optparse'

module Inquisition
  class Options
    def self.parse(arguments)
      opt = new(arguments)
      opt.parse
      opt
    end

    attr_reader :options

    def initialize(arguments)
      @arguments = arguments.dup
      @options = {}
      @parser = OptionParser.new
    end

    def parse
      define_options
      arguments = @parser.order!(@arguments) {}
      @parser.parse!(arguments)
    end

    private

    def define_options
      @parser.banner = 'Usage: bin/rails inquisition [options]'

      @parser.on('-f', '--format FORMATTER', 'Choose a formatter',
                 '  [p]rogress (default)',
                 '  [h]tml') do |value|
        Configuration.instance.loader.add(value)
      end

      @parser.on_tail('-v', '--version', 'Display the version.') do
        @options[:executor] = Executor::Version.new
      end

      @parser.on_tail('-h', '--help', 'You are looking at it.') do
        @options[:executor] = Executor::Help.new(@parser)
      end

      @parser.on_tail('-i', '--init', 'Initialize config file.') do
        @options[:executor] = Executor::Initialize.new
      end
    end
  end
end
