require 'brakeman'

module Inquisition
  module Brakeman
    LEVELS = Hash.new(:low).update(0 => :high, 1 => :medium)

    class Runner < ::Inquisition::Runner
      def call
        ::Brakeman.run(APP_PATH).warnings.each do |warning|
          @issues << Issue.new(severity: LEVELS[warning.confidence], path: warning.file.relative,
                               line: warning.line, message: warning.message.to_s, runner: self)
        end
        issues
      end
    end
  end
end
