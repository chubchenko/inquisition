module Inquisition
  module Outputter
    class HTML
      Outputter.declare(self, :stop)

      def stop(issues)
        Inquisition::Formatters::HtmlFormatter.new(issues.flatten).call
      end
    end
  end
end
