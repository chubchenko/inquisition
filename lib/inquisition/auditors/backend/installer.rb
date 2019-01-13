module Inquisition
  module Auditors
    module Backend
      class Installer < Core::BaseInstaller
        class << self
          private

          def installers
            {
              Bullet::Installer => config_path(:bullet),
              Fasterer::Installer => config_path(:fasterer),
              HamlLint::Installer => config_path(:haml_lint),
              I18nTasks::Installer => config_path(:i18n_tasks),
              LolDba::Installer => config_path(:lol_dba),
              RailsErd::Installer => config_path(:rails_erd),
              Rubocop::Installer => config_path(:rubocop),
              RubocopRspec::Installer => config_path(:rubocop_rspec),
              RubyLint::Installer => config_path(:ruby_lint),
              Simplecov::Installer => config_path(:simplecov),
              SlimLint::Installer => config_path(:slim_lint),
              Undercover::Installer => config_path(:undercover),
              Yamllint::Installer => config_path(:yamllint)
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
