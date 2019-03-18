require 'rails'
require 'execjs'

module Inquisition
  module Core
    module Presenters
      module Pages
        class IndexPagePresenter < PagePresenter
          GIT_FOLDER = '.git'.freeze

          attr_reader :database_presenter, :rails_about_presenter

          def initialize(auditors_tree)
            @database_presenter = Core::Presenters::DatabaseLintersPresenter.new(auditors_tree)
            @rails_about_presenter = Core::Presenters::RailsAboutPresenter.new
            super
          end

          def ruby_version
            RUBY_VERSION
          end

          def rails_version
            Rails::VERSION::STRING
          end

          def quantity_of_gems
            File.foreach(File.join(Dir.pwd, 'Gemfile')).grep(/gem /).count
          end

          def database_adapter
            rails_about_presenter.database_adapter
          end

          def git_existence
            File.exist?(File.join(Dir.pwd, GIT_FOLDER)) ? 'exist' : 'not found'
          end

          def js_runtime_version
            ExecJS.runtime.name
          end

          def included_linters
            BaseConfig.included_linters.map(&:keys).flatten
          end

          def files_summary_table
            FilesSummaryPresenter.new.call
          end
        end
      end
    end
  end
end
