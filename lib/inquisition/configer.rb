module Inquisition
  class Configer
    extend Inquisition::Authorization

    def self.call
      authenticate_installer
      Inquisition::Auditors::Backend::Configer.call
      Inquisition::Auditors::Frontend::Configer.call
      Inquisition::Auditors::Common::Configer.call
    end
  end
end
