module Inquisition
  class Configer
    def self.call
      Inquisition::Auditors::Backend::Configer.call
      Inquisition::Auditors::Frontend::Configer.call
      Inquisition::Auditors::Common::Configer.call
    end
  end
end
