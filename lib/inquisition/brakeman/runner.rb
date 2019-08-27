require 'brakeman'

module Inquisition
  module Brakeman
    class Runner < ::Inquisition::Runner
      def call
        ::Brakeman.run(
          app_path: Rails.root
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
