module Inquisition
  module Core
    module Presenters
      module Data
        module Database
          class MigrationsPresenter < Presenters::StaticPresenter
            MIGRATE_FOLDER = 'db/migrate'.freeze

            private

            def build_presenter
              @build_presenter ||= Dir[File.join(Dir.pwd, MIGRATE_FOLDER, '**')]
            end
          end
        end
      end
    end
  end
end
