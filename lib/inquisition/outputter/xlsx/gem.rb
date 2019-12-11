module Inquisition
  module Outputter
    class Xlsx
      class Gem
        OUTDATED = 'Outdated'.freeze
        HOMEPAGE_URI = 'homepage_uri'.freeze
        VERSION = 'version'.freeze
        FILTRED_ENVIRONMENTS = %i[default].freeze

        def initialize(info)
          @info = info
        end

        def name
          @name ||= gem_info[:bundler].name
        end

        def homepage
          @homepage ||= info.dig(:rubygems, HOMEPAGE_URI)
        end

        def current_version(gem_info)
          @current_version ||= ::Gem.loaded_specs[gem_info[:bundler].name].version
        end

        def latest_version(gem_info)
          @latest_version ||= gem_info.dig(:rubygems, VERSION)
        end

        def status
          @status ||= OUTDATED if ::Gem::Version.new(latest_version(info)) > current_version(info)
        end

        def environment
          @environments ||= (gem_info[:bundler].groups - FILTRED_ENVIRONMENTS).join(', ')
        end

        private

        attr_reader :info
      end
    end
  end
end
