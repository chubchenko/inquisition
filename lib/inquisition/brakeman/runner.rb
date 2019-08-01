require 'brakeman'

module Inquisition
  module Brakeman
    LEVELS = Hash.new(Issue::LEVELS[:low]).update(0 => Issue::LEVELS[:high], 1 => Issue::LEVELS[:medium])

    class Runner < ::Inquisition::Runner
      def call
        ::Brakeman.run('.').warnings.each do |warning|
          @issues << Issue.new(level: LEVELS[warning.confidence], file: warning.file.relative,
                               line: warning.line, message: warning.message.to_s, runner: self)
        end
        @issues
      end
    end
  end
end
