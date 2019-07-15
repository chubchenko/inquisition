module Inquisition
  module Auditors
    module Backend
      class Installer < Core::Installers::MultipleInstaller
        class << self
          private

          def installers
            {
              I18nTasks::Installer => :i18n_tasks,
              # Bullet::Installer => :bullet,
              Fasterer::Installer => :fasterer,
              Reek::Installer => :reek,
              # HamlLint::Installer => :haml_lint,
              LolDba::Installer => :lol_dba,
              # RailsErd::Installer => :rails_erd,
              Rubocop::Installer => :rubocop,
              # RubocopRspec::Installer => :rubocop_rspec,
              RubyLint::Installer => :ruby_lint,
              # Simplecov::Installer => :simplecov,
              # SlimLint::Installer => :slim_lint,
              Yamllint::Installer => :yamllint,
              ActiveRecordDoctor::Installer => :active_record_doctor
            }
          end
        end
      end
    end
  end
end
