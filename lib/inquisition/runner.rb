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
        Auditors::Backend::Runner => config_path(:backend)
        # Auditors::Frontend::Runner => config_path(:frontend)
        # Auditors::Common::Runner => config_path(:common)
      }
    end
  end
end
