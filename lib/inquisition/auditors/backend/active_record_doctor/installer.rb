module Inquisition
  module Auditors
    module Backend
      module ActiveRecordDoctor
        class Installer < Core::Installers::SingleInstaller
          class << self
            private

            def configurers
              [
                Core::Configurers::CopyFileConfigure.new(file: 'active_record_doctor.rake', destination: 'lib/tasks')
              ]
            end
          end
        end
      end
    end
  end
end
