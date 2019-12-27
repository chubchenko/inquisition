module Inquisition
  class Badge
    def self.for(class_name)
      new(class_name.split('::')[1..-2].join('_').gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase)
    end

    def initialize(name)
      @name = name
    end

    def to_s
      @name
    end

    def to_sym
      @name.to_sym
    end
  end
end
