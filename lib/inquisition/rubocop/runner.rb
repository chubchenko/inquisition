require 'rubocop'

module Inquisition
  module RuboCop
    class Runner < ::Inquisition::Runner
      ::RuboCop::ConfigLoader::DOTFILE = 'config/.rubocop.yml'.freeze

      def call
        ::RuboCop::Runner.new(options, ::RuboCop::ConfigStore.new).run(['.'])
      end

      def options
        { require: './lib/inquisition/rubocop/formatter.rb',
          format: 'Formatter',
          formatters: [['Formatter']] }
      end
    end
  end
end
