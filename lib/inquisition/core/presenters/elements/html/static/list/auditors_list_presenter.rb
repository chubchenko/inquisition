module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module List
              class AuditorsListPresenter < Core::Presenters::StaticPresenter
                AUDITOR_GROUP = {
                  database: %i[lol_dba active_record_doctor],
                  code_smells: %i[rails_best_practices reek rubocop ruby_lint yamllint rubocop_rspec],
                  performance: %i[bullet fasterer],
                  security: %i[bundler_audit brakeman dawnscanner],
                  routes: %i[traceroute],
                  diagrams: %i[railroady erd],
                  specs_and_coverage: %i[rspec simplecov]
                }.freeze
                OTHER_GROUP = :other
                SORT_ORDER = [
                  :database,
                  :code_smells,
                  :performanc,
                  :security,
                  :routes,
                  :diagrams,
                  :specs_and_coverage,
                  OTHER_GROUP
                ].freeze

                private

                def build_presenter
                  @build_presenter ||= build_list
                end

                def build_list
                  add_groups
                  sort_by_groups
                  element_presenter.element
                end

                def add_groups
                  AUDITOR_GROUP.each(&method(:add_list_items))
                end

                def add_list_items(group, auditors)
                  element_presenter.add_group(group)
                  element_presenter.add_items(prepare_items(auditors))
                end

                def prepare_items(auditors)
                  auditors.map do |auditor|
                    {
                      auditor_name: auditor,
                      enabled: auditor_enabled?(auditor)
                    }
                  end
                end

                def sort_by_groups
                  element_presenter.sort_by_groups(SORT_ORDER)
                end

                def element_presenter
                  @element_presenter ||= Dynamic::ListWithGroupsPresenter.new
                end

                def data
                  @data ||= Data::Auditors::AuditorsPresenter.instance.call
                end
              end
            end
          end
        end
      end
    end
  end
end
