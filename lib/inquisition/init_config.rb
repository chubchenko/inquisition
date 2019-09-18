module Inquisition
  module InitConfig
    module_function

    def result
      create_config
      File.exist?(File.join(Rails.root, '.inquisition.yml')) ? success : failure
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

    def success
      'Config file was created successfully'
    end

    def failure
      'Something went wrong'
    end
  end
end
