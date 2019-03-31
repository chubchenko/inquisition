module Inquisition
  class Outputer
    OUTPUTERS_FORMAT = {
      'html' => Inquisition::Core::Outputers::HtmlOutputer
    }.freeze

    def self.call(options)
      OUTPUTERS_FORMAT[options['format']].new.call
    end
  end
end
