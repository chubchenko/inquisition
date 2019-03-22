module Inquisition
  module Core
    module Presenters
      class MigrationPresenter < BasePresenter
        MIGRATE_FOLDER = 'db/migrate'.freeze

        def total_migrations
          migrations.count
        end

        def schema_version
          migrations.map(&method(:migration_to_time)).max.to_s
        end

        def migration_to_time(migration)
          Time.parse(migration.scan(/\d/).join(''))
        end

        private

        def migrations
          @migrations ||= Dir[File.join(Dir.pwd, MIGRATE_FOLDER, '**')]
        end
      end
    end
  end
end
