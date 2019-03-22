module Inquisition
  module Core
    module Runners
      class MultipleRunner < BaseRunner
        def call
          convert_to_hash(run_runners)
        end

        private

        def run_runners
          runners.map do |runner, path|
            { "#{runner.new.auditor_name}": runner.new.call } if BaseConfig.config_enabled?(*path)
          end
        end

        def convert_to_hash(array)
          array.each_with_object({}) do |auditor, obj|
            value = auditor.values.first
            obj[auditor.keys.first] = value.is_a?(Array) ? convert_to_hash(value) : value
          end
        end

        def runners
          {}
        end

        def config_path(*keys)
          [:linters, *path, *keys]
        end

        def path
          []
        end
      end
    end
  end
end
