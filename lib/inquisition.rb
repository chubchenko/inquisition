require 'inquisition/collector'
require 'inquisition/configuration'
require 'inquisition/issue'
require 'inquisition/runner'
require 'inquisition/version'
require 'pry'

require 'inquisition/active_record_doctor/runner_helper'
require 'inquisition/active_record_doctor/extraneous_indexes_runner'
require 'inquisition/active_record_doctor/missing_foreign_keys_runner'
require 'inquisition/active_record_doctor/unindexed_deleted_at_runner'
require 'inquisition/active_record_doctor/unindexed_foreign_keys_runner'
require 'inquisition/brakeman/runner'
require 'inquisition/bundler/audit/runner'

module Inquisition
end
