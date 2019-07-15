require 'thor'

module Inquisition
  class CLI < Thor
    desc 'call', 'Run Inquisition'
    def call
      Collector.()
    end
  end
end
