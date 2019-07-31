require 'thor'

module Inquisition
  class CLI < Thor
    default_command :execute

    desc 'execute', 'Run Inquisition'
    def execute
      Collector.new.call
    end

    desc 'version', 'Print the version of the gem'
    def version
      say(Version, :green)
    end
    map ['-v', '--version'] => :version
  end
end
