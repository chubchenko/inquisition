module Inquisition
  module InitConfig
    module_function

    def result
      create_config
      File.exist?(Rails.root, '.inquisition.yml') ? sucess : fail
    end

    def create_config
      File.open(File.join(Rails.root, '.inquisition.yml'), 'w') do |line|
        line.write("plugins:\n")
        runners.each { |runner| line.write("  #{runner}:\n    enabled: true\n") }
        line.write("\nverbose: false\n")
      end
    end

    def runners
      Inquisition::Runner.descendants.map { |runner| runner.badge.to_s }
    end

    def sucess
      'Config file was created successfully'
    end

    def fail
      'Something went wrong'
    end
  end
end
