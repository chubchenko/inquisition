require 'thor'

module Inquisition
  class CLI < Thor
    default_command :execute

    desc 'execute', 'Run Inquisition'
    def execute
      Collector.new.call
    end
  end
end
