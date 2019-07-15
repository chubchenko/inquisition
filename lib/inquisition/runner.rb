module Inquisition
  class Runner
    def self.collection
      @collection ||= []
    end

    def self.inherited(descendant)
      collection.push(descendant)
    end

    def self.call
      new.()
    end
  end
end
