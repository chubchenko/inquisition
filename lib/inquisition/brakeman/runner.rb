require 'brakeman'
require 'brakeman/scanner'

module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      def call
        ::Brakeman.run(
          app_path: APP_PATH
        ).warnings.map(
          &method(:issue_for)
        )
      end

      private

      def issue_for(warning)
        Issue.new(Vulnerability.new(warning).to_h.merge(runner: self))
      end
    end
  end
end
