require 'lol_dba'

module Inquisition
  module LolDba
    class Runner < ::Inquisition::Runner
      def call
        compose_issues
        issues
      end

      private

      def compose_issues
        ::LolDba::IndexFinder.check_for_indexes.map do |table, index_arr|
          create_issue_with_every_index(table, index_arr)
        end.flatten
      end

      def create_issue_with_every_index(table, index_arr)
        index_arr.map { |index| issues << create_issue(table, index) }
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
    end
  end
end
