require 'singleton'

module Inquisition
  class BaseConfig
    include Singleton

    CONFIG_FILE_NAME = 'inquisition.yml'.freeze
    TARGET_DIRECTORY = Dir.pwd
    BACKEND_PATH = %i[inquisition linters backend].freeze
    FRONTEND_PATH = %i[inquisition linters frontend].freeze
    AUDITORS_GROUP = %i[inquisition linters backend frontend active_record_doctor].freeze
    AUDITOR_PATH = {
      inquisition: %i[inquisition],
      linters: %i[inquisition linters],
      backend: BACKEND_PATH,
      bundler_audit: [*BACKEND_PATH, :bundler_audit],
      brakeman: [*BACKEND_PATH, :brakeman],
      rails_best_practices: [*BACKEND_PATH, :rails_best_practices],
      reek: [*BACKEND_PATH, :reek],
      dawnscanner: [*BACKEND_PATH, :dawnscanner],
      rubocop: [*BACKEND_PATH, :rubocop],
      ruby_lint: [*BACKEND_PATH, :ruby_lint],
      bullet: [*BACKEND_PATH, :bullet],
      fasterer: [*BACKEND_PATH, :fasterer],
      railroady: [*BACKEND_PATH, :railroady],
      erd: [*BACKEND_PATH, :erd],
      traceroute: [*BACKEND_PATH, :traceroute],
      lol_dba: [*BACKEND_PATH, :lol_dba],
      active_record_doctor: [*BACKEND_PATH, :active_record_doctor],
      extraneous_indexes: [*BACKEND_PATH, :active_record_doctor],
      missing_foreign_keys: [*BACKEND_PATH, :active_record_doctor, :missing_foreign_keys],
      missing_non_null_constraint: [*BACKEND_PATH, :active_record_doctor, :missing_non_null_constraint],
      missing_presence_validation: [*BACKEND_PATH, :active_record_doctor, :missing_presence_validation],
      missing_unique_indexes: [*BACKEND_PATH, :active_record_doctor, :missing_unique_indexes],
      undefined_table_references: [*BACKEND_PATH, :active_record_doctor, :undefined_table_references],
      unindexed_deleted_at: [*BACKEND_PATH, :active_record_doctor, :unindexed_deleted_at],
      unindexed_foreign_key: [*BACKEND_PATH, :active_record_doctor, :unindexed_foreign_key],
      rspec: [*BACKEND_PATH, :rspec],
      rspec_rubocop: [*BACKEND_PATH, :rspec_rubocop],
      simplecov: [*BACKEND_PATH, :simplecov],
      yamllint: [*BACKEND_PATH, :yamllint],
      frontend: FRONTEND_PATH,
      i18n_tasks: [*FRONTEND_PATH, :i18n_tasks],
      haml_lint: [*FRONTEND_PATH, :haml_lint],
      slim_lint: [*FRONTEND_PATH, :slim_lint],
      erb_lint: [*FRONTEND_PATH, :erb_lint],
      scss_lint: [*FRONTEND_PATH, :scss_lint],
      stylelint: [*FRONTEND_PATH, :stylelint],
      eslint: [*FRONTEND_PATH, :eslint],
      yarn_check: [*FRONTEND_PATH, :yarn_check],
      npm_audit: [*FRONTEND_PATH, :npm_audit]
    }.freeze

    def initialize_config
      create_config unless config_exist?
    end

    def config_exist?
      Dir.glob(File.join(TARGET_DIRECTORY, CONFIG_FILE_NAME)).any?
    end

    def auditor_enabled?(auditor)
      path = AUDITOR_PATH[auditor]
      path ? path_chain_enabled?(path) : false
    end

    private

    def path_chain_enabled?(path)
      path.each_with_index.map(&method(:chain_item_enabled?)).none?(false)
    end

    def chain_item_enabled?(item, index)
      config_path_enabled?(*AUDITOR_PATH[item][0, index + 1])
    end

    def config_path_enabled?(*path)
      configs.dig(*path, :Enabled) == true
    end

    def configs
      @configs ||= YAML.load_file(File.join(TARGET_DIRECTORY, CONFIG_FILE_NAME))
    end

    def create_config
      FileUtils.cp config_file_template, TARGET_DIRECTORY, preserve: true, verbose: false
    end

    def config_file_template
      File.join(File.dirname(__dir__), 'inquisition', 'utils', CONFIG_FILE_NAME)
    end
  end
end
