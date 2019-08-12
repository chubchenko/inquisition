require 'colorize'

module Inquisition
  class Collector
    SIGN_SUCCESS = '.'.colorize(:green).freeze
    SIGN_FAILED = 'F'.colorize(:red).freeze

    def initialize(collection: Runner.collection)
      @collection = collection.select(&:enabled?)
    end

    def call
      @collection.each_with_object([]) do |runner, memo|
        memo << output(runner.new.call)
      end.flatten
    end

    private

    def output(runner)
      print runner.any? ? SIGN_FAILED : SIGN_SUCCESS
      runner
    end
  end
end
