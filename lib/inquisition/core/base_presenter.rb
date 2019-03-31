module Inquisition
  module Core
    class BasePresenter
      include Helpers::AuditorsHelper
      attr_reader :data

      DEFAULT_GROUP_NAME = :other
      CUSTOM_AUDITOR_GROUP = {
        database: %i[lol_dba active_record_doctor],
        code_smells: %i[rails_best_practices reek rubocop ruby_lint yamllint rubocop_rspec],
        performance: %i[bullet fasterer],
        performances: %i[bullet fasterer],
        security: %i[bundler_audit brakeman dawnscanner],
        routes: %i[traceroute],
        diagrams: %i[railroady erd],
        specs_and_coverage: %i[rspec simplecov]
      }.freeze
      SORT_ORDER_BY_GROUPS = [
        :database,
        :code_smells,
        :performance,
        :performances,
        :security,
        :routes,
        :diagrams,
        :specs_and_coverage,
        DEFAULT_GROUP_NAME
      ].freeze

      def call(data = nil)
        @data = data
        build_presenter
      end

      def run_cli(command)
        begin
          stdout = Open3.capture3(command).first
        rescue Errno::ENOENT
          stdout = ''
        end
        stdout
      end

      def build_presenter
        raise NotImplementedError
      end
    end
  end
end
