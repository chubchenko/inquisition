module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Menu
              class MenuItemsPresenter < Core::Presenters::StaticPresenter
                MENU_ITEMS = [
                  {
                    name: 'Backend',
                    child_items: [
                      {
                        name: 'Database auditiors',
                        child_items: [
                          { name: 'Database summary' },
                          { name: 'Lol dba' },
                          { name: 'Active record doctor' }
                        ]
                      },
                      {
                        name: 'Code Smells',
                        child_items: [
                          { name: 'Summary' },
                          { name: 'Rails best practices' },
                          { name: 'Reek' },
                          { name: 'Rubocop' },
                          { name: 'Ruby lint' },
                          { name: 'Yamllint' },
                          { name: 'Rubocop_rspec' }
                        ]
                      },
                      {
                        name: 'Perfomance',
                        child_items: [
                          { name: 'Fasterer' },
                          { name: 'Bullet' }
                        ]
                      },
                      {
                        name: 'Security',
                        child_items: [
                          { name: 'Bundler Audit' },
                          { name: 'Brakeman' },
                          { name: 'Dawnscanner' }
                        ]
                      },
                      {
                        name: 'Routes',
                        child_items: [
                          { name: 'Traceroute' }
                        ]
                      },
                      {
                        name: 'Diagrams',
                        child_items: [
                          { name: 'Railsroady' },
                          { name: 'Erd' }
                        ]
                      },
                      {
                        name: 'Specs and coverage',
                        child_items: [
                          { name: 'Rspec' },
                          { name: 'Simplecov' }
                        ]
                      }
                    ]
                  },
                  { name: 'Frontend' },
                  { name: 'Hottest issues' },
                  { name: 'Issues and solutions' }
                ].freeze

                private

                def build_presenter
                  @build_presenter = MENU_ITEMS.inject([], &method(:build_menu))
                end

                def build_menu(result, menu)
                  name = menu[:name]
                  return [] unless enabled_link?(name)

                  item = build_item(name, menu[:link])
                  item[:child_items] = build_child_menu(menu[:child_items])
                  result << item
                end

                def enabled_link?(name)
                  name = build_link_name(name).to_sym
                  auditors_list.none?(name) || auditor_enabled?(name)
                end

                def build_child_menu(child_menu)
                  child_menu.inject([], &method(:build_menu)) if child_menu && child_menu.any?
                end

                def build_item(name, link)
                  link_url = link || build_url(name)
                  Dynamic::MenuItemPresenter.new(name: name, link: link_url).element
                end

                def build_url(name)
                  build_link_name(name) + '.html'
                end

                def build_link_name(name)
                  name.split.map(&:downcase).join('_')
                end
              end
            end
          end
        end
      end
    end
  end
end
