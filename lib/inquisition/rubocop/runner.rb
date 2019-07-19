require 'rubocop'

module Inquisition
  module RuboCop
    class Runner < ::Inquisition::Runner
      ::RuboCop::ConfigLoader::DOTFILE = 'config/.rubocop.yml'.freeze

      def call
        ::RuboCop::Runner.new({}, ::RuboCop::ConfigStore.new).run(['.'])
      end
    end
  end
end
