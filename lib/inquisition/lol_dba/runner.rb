require 'lol_dba'

module Inquisition
  module LolDba
    class Runner < ::Inquisition::Runner
      def call
        @errors = ::LolDba::IndexFinder.check_for_indexes
        compose_issues
        @issues
      end

      private

      def compose_issues
        @errors.map { |table, index_arr| create_issue_with_every_index(table, index_arr) }.flatten
      end

      def create_issue_with_every_index(table, index_arr)
        index_arr.map { |index| @issues << create_issue(table, index) }
      end

      def create_issue(table, index)
        Inquisition::Issue.new(
          severity: :low,
          category: :performance,
          line: nil,
          runner: self,
          path: nil,
          message: "You have not index in table `#{table}`, column `#{index}`"
        )
      end
    end
  end
end
