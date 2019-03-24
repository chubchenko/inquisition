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
                    link: '#'
                  },
                  {
                    name: 'Active record doctor',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Code Smells',
                child_items: [
                  {
                    name: 'Summary',
                    link: '#'
                  },
                  {
                    name: 'Rails best practices',
                    link: '#'
                  },
                  {
                    name: 'Reek',
                    link: '#'
                  },
                  {
                    name: 'Rubocop',
                    link: '#'
                  },
                  {
                    name: 'Ruby lint',
                    link: '#'
                  },
                  {
                    name: 'Yamllint',
                    link: '#'
                  },
                  {
                    name: 'Rubocop-rspec',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Perfomance',
                child_items: [
                  {
                    name: 'Fasterer',
                    link: '#'
                  },
                  {
                    name: 'Bullet',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Security',
                child_items: [
                  {
                    name: 'Bundler Audit',
                    link: '#'
                  },
                  {
                    name: 'Brakeman',
                    link: '#'
                  },
                  {
                    name: 'Dawnscanner',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Routes',
                child_items: [
                  {
                    name: 'Traceroute',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Diagrams',
                child_items: [
                  {
                    name: 'Railsroady',
                    link: '#'
                  },
                  {
                    name: 'Erd',
                    link: '#'
                  }
                ]
              },
              {
                name: 'Specs & coverage',
                child_items: [
                  {
                    name: 'Rspec',
                    link: '#'
                  },
                  {
                    name: 'Simplecov',
                    link: '#'
                  }
                ]
              }
            ]
          },
          {
            name: 'Frontend',
            link: '#'
          }
        ].freeze

        private

        def build_presenter
          @items = MENU_ITEMS.map(&method(:build_menu))
        end

        def build_menu(menu)
          item = build_item(menu[:name], menu[:link])
          item[:child_items] = build_child_menu(menu[:child_items])
          item
        end

        def build_child_menu(child_menu)
          child_menu.map(&method(:build_menu)) if child_menu && child_menu.any?
        end

        def build_item(name, link = '#need_change')
          Core::Presenters::MenuItemPresenter.new(name: name, link: link).call
        end

        def include_path?(path)
          BaseConfig.config_enabled?(:linters, path)
        end
      end
    end
  end
end
