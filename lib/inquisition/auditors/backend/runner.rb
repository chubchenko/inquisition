module Inquisition
  module Auditors
    module Backend
      class Runner < Core::BaseRunner
        class << self
          private

          def runners
            {
              # Bullet::Runner => config_path(:bullet),
              Fasterer::Runner => config_path(:fasterer),
              Reek::Runner => config_path(:reek),
              Dawnscanner::Runner => config_path(:dawnscanner),
              BundlerAudit::Runner => config_path(:bundler_audit),
              RailsBestPractices::Runner => config_path(:rails_best_practices),
              # HamlLint::Runner => config_path(:haml_lint),
              # LolDba::Runner => config_path(:lol_dba),
              # RailsErd::Runner => config_path(:rails_erd),
              Rubocop::Runner => config_path(:rubocop),
              # RubocopRspec::Runner => config_path(:rubocop_rspec),
              RubyLint::Runner => config_path(:ruby_lint),
              # Simplecov::Runner => config_path(:simplecov),
              # SlimLint::Runner => config_path(:slim_lint),
              Yamllint::Runner => config_path(:yamllint)
            }
          end

          def config_path(*path)
            [:linters, :backend, *path]
          end
        end
      end
    end
  end
end
