module Inquisition
  module Auditors
    module Backend
      class Installer < Core::Installers::MultipleInstaller
        class << self
          private

          def installers
            {
              # Bullet::Installer => config_path(:bullet),
              Fasterer::Installer => config_path(:fasterer),
              Reek::Installer => config_path(:reek),
              # HamlLint::Installer => config_path(:haml_lint),
              LolDba::Installer => config_path(:lol_dba),
              # RailsErd::Installer => config_path(:rails_erd),
              Rubocop::Installer => config_path(:rubocop),
              # RubocopRspec::Installer => config_path(:rubocop_rspec),
              RubyLint::Installer => config_path(:ruby_lint),
              # Simplecov::Installer => config_path(:simplecov),
              # SlimLint::Installer => config_path(:slim_lint),
              Yamllint::Installer => config_path(:yamllint),
              ActiveRecordDoctor::Installer => config_path(:active_record_doctor)
            }
          end

          def path
            [:backend]
          end
        end
      end
    end
  end
end
