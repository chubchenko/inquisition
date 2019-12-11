require 'gems'
require_relative 'gem'

module Inquisition
  module Outputter
    class Xlsx
      class GemSet
        def call
          collect_gems_info.map { |info| Gem.new(info) }
        end

        private

        def collect_gems_info
          ::Bundler.load.dependencies.map do |gem|
            {
              bundler: gem,
              rubygems: Gems.info(gem.name)
            }
          end
        end
      end
    end
  end
end
