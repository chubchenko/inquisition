module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Dynamic
            class MenuItemPresenter < Core::Presenters::DynamicPresenter
              attr_reader :params

              def initialize(params)
                @params = params
              end

              def element
                name = params[:name]
                @element ||= {
                  name: name,
                  link: params[:link],
                  class: name.split.map(&:downcase).join('_')
                }
              end
            end
          end
        end
      end
    end
  end
end
