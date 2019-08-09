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
  end
end
