module Inquisition
  class Runner < Core::Runners::MultipleRunner
    include Inquisition::Authorization

    def call
      authenticate_runner
      super
    end

    private

    def runners
      {
        Auditors::Backend::Runner => :backend
        # Auditors::Common::Runner => config_path(:common)
      }
    end
  end
end
