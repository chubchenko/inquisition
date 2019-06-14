module Inquisition
  module Core
    module Presenters
      module Pages
        class PartialPresenter
          attr_reader :params

          def initialize(params)
            @params = params
          end
        end
      end
    end
  end
end
