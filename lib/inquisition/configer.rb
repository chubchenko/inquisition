module Inquisition
  class Configer
    extend Inquisition::Authorization

    class << self
      def call
        authenticate_installer
        run_configers
      end

      private

      def run_configers
        Inquisition::Auditors::Backend::Configer.call
        Inquisition::Auditors::Frontend::Configer.call
        Inquisition::Auditors::Common::Configer.call
      end
    end
  end
end
