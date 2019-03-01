module Inquisition
  class Outputer
    OUTPUTERS_FORMAT = {
      'html' => Inquisition::Core::Outputers::HtmlOutputer
    }.freeze

    def self.call(options, formatters:)
      OUTPUTERS_FORMAT[options['format']].new(formatters).call
    end
  end
end
