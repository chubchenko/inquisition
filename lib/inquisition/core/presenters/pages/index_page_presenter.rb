require 'rails'

module Inquisition
  module Core
    module Presenters
      module Pages
        class IndexPagePresenter < PagePresenter
          attr_reader :database_presenter

          def initialize(auditors_tree)
            @database_presenter = Core::Presenters::DatabaseLintersPresenter.new(auditors_tree)
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

          def total_code_errors
            'soon'
          end

          def total_database_errors
            @database_presenter.total_errors
          end

          def included_linters
            BaseConfig.included_linters.map(&:count).sum
          end
        end
      end
    end
  end
end
