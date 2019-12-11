require 'gems'

module Inquisition
  module Outputter
    class Xlsx
      class GemsInfo
        attr_reader :collection

        OUTDATED = 'Outdated'.freeze
        HOMEPAGE_URI = 'homepage_uri'.freeze
        VERSION = 'version'.freeze
        FILTRED_ENVIRONMENTS = %i[default].freeze

        def initialize(collection)
          @collection = collection
        end

        def call
          prepare_info
        end

        private

        def prepare_info
          collect_gems_info.map do |info|
            binding.pry
            # detailed_status = GemDetailedStatus.new(info).call

            {
              name: info[:bundler].name,
              homepage: info.dig(:rubygems, HOMEPAGE_URI),
              current_version: current_version(info),
              latest_version: latest_version(info),
              status: latest_version(info) > current_version(info) ? OUTDATED : nil,
              environment: environment(info),
              detailed_status: nil,
              color: nil
            }
          end
        end

        def collect_gems_info
          @collect_gems_info ||= ::Bundler.load.dependencies.map do |gem|
            {
              bundler: gem,
              rubygems: Gems.info(gem.name)
            }
          end
        end

        def current_version(gem_info)
          Gem.loaded_specs[gem_info[:bundler].name].version.to_s
        end

        def latest_version(gem_info)
          gem_info.dig(:rubygems, VERSION)
        end

        def environment(gem_info)
          environments = gem_info[:bundler].groups - FILTRED_ENVIRONMENTS
          environments.join(', ')
        end
      end
    end
  end
end
