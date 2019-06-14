module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class TablesPresenter < Presenters::StaticPresenter
            DATABASE_SCHEMA_FILE = 'db/schema.rb'.freeze

            private

            def build_presenter
              @build_presenter ||= schema_tables.map { |table| table.split('"') }.map { |table| table[1] }
            end

            def schema_tables
              File.foreach(File.join(Dir.pwd, DATABASE_SCHEMA_FILE)).grep(/create_table/)
            end
          end
        end
      end
    end
  end
end
