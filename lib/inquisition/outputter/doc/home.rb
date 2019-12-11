module Inquisition
  module Outputter
    class Doc
      class Home
        def produce
          binding
        end

        def name
          @name ||= ::Rails.application.class.parent_name.underscore.upcase
        end

        def date
          @date ||= begin
            [
              ::Date.today.day.ordinalize,
              ::Date::MONTHNAMES[Date.today.month],
              ::Date.today.year
            ].join(' ')
          end
        end
      end
    end
  end
end
