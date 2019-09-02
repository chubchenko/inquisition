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
      issues = call

      if issues.empty?
        fanout.example_passed(self)
      else
        fanout.example_failed(self)
      end
      issues
    end
  end
end
