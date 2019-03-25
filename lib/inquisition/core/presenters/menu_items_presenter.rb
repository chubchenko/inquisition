module Inquisition
  module Core
    module Presenters
      class MenuItemsPresenter < BasePresenter
        DATABASE_SUMMARY_PAGE = 'database_summary.html'.freeze
        MENU_ITEMS = [
          {
            name: 'Backend',
            child_items: [
              {
                name: 'Database auditiors',
                child_items: [
                  {
                    name: 'Summary',
                    link: 'database_summary.html'
                  },
                  {
                    name: 'Lol dba',
                    link: 'lol_dba.html'
                  },
                  {
                    name: 'Active record doctor',
                    link: 'active_record_doctor.html'
                  }
                ]
              },
              {
                name: 'Code Smells',
                child_items: [
                  {
                    name: 'Summary',
                    link: 'code_smells_summary.html'
                  },
                  {
                    name: 'Rails best practices',
                    link: 'rails_best_practices.html'
                  },
                  {
                    name: 'Reek',
                    link: 'reek.html'
                  },
                  {
                    name: 'Rubocop',
                    link: 'rubocop.html'
                  },
                  {
                    name: 'Ruby lint',
                    link: 'ruby_lint.html'
                  },
                  {
                    name: 'Yamllint',
                    link: 'yamllint.html'
                  },
                  {
                    name: 'Rubocop-rspec',
                    link: 'rspec_rubocop.html'
                  }
                ]
              },
              {
                name: 'Perfomance',
                child_items: [
                  {
                    name: 'Fasterer',
                    link: 'fasterer.html'
                  },
                  {
                    name: 'Bullet',
                    link: 'bullet.html'
                  }
                ]
              },
              {
                name: 'Security',
                child_items: [
                  {
                    name: 'Bundler Audit',
                    link: 'bundler_audit.html'
                  },
                  {
                    name: 'Brakeman',
                    link: 'brakeman.html'
                  },
                  {
                    name: 'Dawnscanner',
                    link: 'dawnscanner.html'
                  }
                ]
              },
              {
                name: 'Routes',
                child_items: [
                  {
                    name: 'Traceroute',
                    link: 'traceroute.html'
                  }
                ]
              },
              {
                name: 'Diagrams',
                child_items: [
                  {
                    name: 'Railsroady',
                    link: 'railsroady.html'
                  },
                  {
                    name: 'Erd',
                    link: 'erd.html'
                  }
                ]
              },
              {
                name: 'Specs and coverage',
                child_items: [
                  {
                    name: 'Rspec',
                    link: 'rspec.html'
                  },
                  {
                    name: 'Simplecov',
                    link: 'simplecov.html'
                  }
                ]
              }
            ]
          },
          {
            name: 'Frontend',
            link: 'frontend.html'
          },
          {
            name: 'Hottest issues',
            link: 'hottest_issues.html'
          },
          {
            name: 'Issues and solutions',
            link: 'issues_and_solutions.html'
          }
        ].freeze

        MENU_GUARD = {
          lol_dba: %i[backend lol_dba],
          fasterer: %i[backend fasterer],
          reek: %i[backend reek],
          dawnscanner: %i[backend dawnscanner],
          rails_best_practices: %i[backend rails_best_practices],
          rubocop: %i[backend rubocop],
          ruby_lint: %i[backend ruby_lint],
          yamllint: %i[backend yamllint],
          bundler_audit: %i[backend bundler_audit],
          brakeman: %i[backend brakeman],
          active_record_doctor: %i[backend active_record_doctor]
        }.freeze

        private

        def build_presenter
          @items = MENU_ITEMS.map(&method(:build_menu)).map(&method(:compact_menu))
        end

        def compact_menu(menu)
          child_items = menu[:child_items]
          if child_items
            child_items.compact!
            child_items.map!(&method(:compact_menu)) if child_items.any?
            menu[:child_items] = child_items
          end
          menu
        end

        def build_menu(menu)
          return unless item_included?(menu)

          item = build_item(menu[:name], menu[:link])
          item[:child_items] = build_child_menu(menu[:child_items])
          item
        end

        def item_included?(menu)
          guard_path = MENU_GUARD[menu[:name].split.map(&:downcase).join('_').to_sym]
          guard_path ? include_path?(guard_path) : true
        end

        def build_child_menu(child_menu)
          child_menu.map(&method(:build_menu)) if child_menu && child_menu.any?
        end

        def build_item(name, link = '#need_change')
          Core::Presenters::MenuItemPresenter.new(name: name, link: link).call
        end

        def include_path?(path)
          BaseConfig.config_enabled?(:linters, *path)
        end
      end
    end
  end
end
