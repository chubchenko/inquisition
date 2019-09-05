require 'inquisition/plugin'
require 'inquisition/collector'
require 'inquisition/configuration'
require 'inquisition/issue'
require 'inquisition/badge'
require 'inquisition/severity'
require 'inquisition/category'
require 'inquisition/runner'
require 'inquisition/version'
require 'inquisition/logger'
require 'inquisition/railtie'

require 'inquisition/active_record_doctor/runner'
require 'inquisition/active_record_doctor/vulnerability'
require 'inquisition/brakeman/vulnerability'
require 'inquisition/brakeman/runner'
require 'inquisition/bundler/audit/runner'
require 'inquisition/fasterer/runner'
require 'inquisition/rails_best_practices/runner'
require 'inquisition/rails_best_practices/issue'
require 'inquisition/rails_best_practices/categorizer'
require 'inquisition/rubocop'
require 'inquisition/lol_dba/runner'
require 'inquisition/fasterer/runner'
require 'inquisition/rubycritic/runner'
require 'inquisition/traceroute/runner'
require 'inquisition/factory_bot/runner'
require 'inquisition/factory_bot/factory_bot_modified_linter'

require_relative 'inquisition/outputter'
require_relative 'inquisition/options'
require_relative 'inquisition/fanout'
require_relative 'inquisition/executor'

module Inquisition
  def self.logger
    @logger ||= begin
      if Configuration.instance.verbose?
        Logger.new(STDOUT, level: Logger::INFO)
      else
        Logger.new(File.open(File::NULL, 'w'))
      end
    end
  end

  def self.root
    File.dirname(__dir__)
  end
end
