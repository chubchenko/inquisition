require 'lol_dba'

module Inquisition
  module LolDba
    class Runner < ::Inquisition::Runner
      def call
        ::LolDba::IndexFinder.check_for_indexes.map do |table, set|
          decompose(table, set)
        end.flatten
      end

      private

      def decompose(table, set)
        set.map do |columns|
          issue_for(table, columns)
        end
      end

      def issue_for(table, columns)
        Inquisition::Issue.new(
          MissingIndex.new(table: table, columns: columns).to_h.merge(runner: self)
        )
      end
    end
  end
end
