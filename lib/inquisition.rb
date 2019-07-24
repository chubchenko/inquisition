require 'inquisition/collector'
require 'inquisition/configuration'
require 'inquisition/issue'
require 'inquisition/runner'
require 'inquisition/version'
require 'inquisition/logger'

require 'inquisition/active_record_doctor/runner'
require 'inquisition/brakeman/runner'
require 'inquisition/bundler/audit/runner'
require 'inquisition/rails_best_practices/runner'
require 'inquisition/rubocop/rubocop_modified_runner'
require 'inquisition/rubocop/runner'
require 'inquisition/lol_dba/runner'
require 'inquisition/fasterer/runner'
require 'inquisition/rubycritic/runner'
require 'inquisition/traceroute/runner'

module Inquisition
end
