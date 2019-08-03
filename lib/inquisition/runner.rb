module Inquisition
  class Runner
    include Plugin

    attr_reader :issues
    APP_PATH = '.'.freeze

    class << self
      def badge
        @badge ||= Badge.for(name)
      end

      def enabled?
        Configuration.instance.to_h.fetch('plugins', {}).fetch(badge.to_s, {}).fetch('enabled', false)
      end
    end

    def initialize
      @issues = []
    end
  end
end
