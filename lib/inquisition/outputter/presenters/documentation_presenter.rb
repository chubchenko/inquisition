module Inquisition
  module Outputter
    module Presenters
      class DocumentationPresenter
        attr_reader :collection

        def initialize(collection)
          @collection = collection
        end

        def produce
          binding
        end

        def date_today
          "#{Date.today.day}th #{Date::MONTHNAMES[Date.today.month]} #{Date.today.year}"
        end

      end
    end
  end
end
