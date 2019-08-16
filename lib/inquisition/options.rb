require 'optparse'

module Inquisition
  class Options
    def self.parse(arguments)
      new(arguments).parse
    end

    def initialize(arguments)
      @arguments = arguments.dup
      @parser = OptionParser.new
    end

    def parse
      define_options
      arguments = @parser.order!(@arguments) {}
      @parser.parse!(arguments)
    end

    private

    def define_options
      @parser.banner = 'Usage: rake inquisition:run [options]'

      @parser.on('-f', '--format FORMATTER') do |value|
        Configuration.instance.loader.add(value)
      end

      # Utility options:

      # @parser.on_tail('-l', '--list') do
      #   # ...
      #   exit
      # end

      @parser.on_tail('-v', '--version') do
        puts Inquisition::Version
        exit
      end

      @parser.on_tail('-h', '--help') do
        puts @parser
        exit
      end
    end
  end
end
