module Inquisition
  class Runner
    include Plugin

    class << self
      def badge
        @badge ||= Badge.for(name)
      end

      def enabled?
        Configuration.instance.to_h.dig('plugins', badge.to_s, 'enabled') || false
      end
    end

    def initialize
      @issues = []
    end

    def run(fanout)
      @issues = call
      fanout.example_passed(self) if success?
      fanout.example_failed(self) if failure?
      @issues
    end

    private

    attr_reader :issues

    def success?
      @issues.empty?
    end

    def failure?
      !success?
    end
  end
end
