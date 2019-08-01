require 'lol_dba'

module Inquisition
  module LolDba
    class Runner < ::Inquisition::Runner
      attr_reader :errors

      def call
        load_environment
        @errors = ::LolDba::IndexFinder.check_for_indexes
        compose_issues
      end

      private

      def compose_issues
        errors.map { |table, index_arr| create_issue_with_every_index(table, index_arr) }.flatten
      end

      def create_issue_with_every_index(table, index_arr)
        index_arr.map { |index| create_issue(table, index) }
      end

      def create_issue(table, index)
        Inquisition::Issue.new(
          severity: :low,
          line: nil,
          runner: self,
          path: nil,
          message: "You have not index in table `#{table}`, column `#{index}`"
        )
      end

      def load_environment
        require "#{Dir.pwd}/config/environment"
      end
    end
  end
end
