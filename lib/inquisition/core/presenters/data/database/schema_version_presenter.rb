require 'time'

module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class SchemaVersionPresenter < Presenters::StaticPresenter
            private

            def build_presenter
              @build_presenter ||= {
                date: migration_time.strftime('%d-%m-%Y'),
                time: migration_time.strftime('%H:%m:%S')
              }
            end

            def migration_time
              @migration_time ||= migrations.map(&method(:migration_to_time)).max
            end

            def migration_to_time(migration)
              Time.parse(migration.scan(/\d/).join(''))
            end

            def migrations
              MigrationsPresenter.instance.call
            end
          end
        end
      end
    end
  end
end
