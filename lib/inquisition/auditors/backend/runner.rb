module Inquisition
  module Auditors
    module Backend
      class Runner < Core::Runners::MultipleRunner
        private

        def runners
          {
            I18nTasks::Runner => :i18n_tasks,
            # Fasterer::Runner => :fasterer,
            # Reek::Runner => :reek,
            # Dawnscanner::Runner => :dawnscanner,
            # BundlerAudit::Runner => :bundler_audit,
            # RailsBestPractices::Runner => :rails_best_practices,
            # Rubocop::Runner => :rubocop,
            # RubyLint::Runner => :ruby_lint,
            # Yamllint::Runner => :yamllint,
            # LolDba::Runner => :lol_dba,
            # ActiveRecordDoctor::Runner => :active_record_doctor
            Brakeman::Runner => :brakeman
            # Bullet::Runner => config_path(:bullet),
            # HamlLint::Runner => config_path(:haml_lint),
            # RailsErd::Runner => config_path(:rails_erd),
            # RubocopRspec::Runner => config_path(:rubocop_rspec),
            # Simplecov::Runner => config_path(:simplecov),
            # SlimLint::Runner => config_path(:slim_lint)
          }
        end
      end
    end
  end
end
