# frozen_string_literal: true

class ElectionResult < ApplicationRecord
  belongs_to :election
  belongs_to :party
  belongs_to :country

  validates :votes, numericality: { greater_than_or_equal_to: 0 }
  validates :party, uniqueness: { scope: :election_id, message: "should have only one result per election" }

  scope :of_election, ->(election) { where(election: election) }

  class << self
    def of(options)
      query = self
      election, country, party = options.values_at(:election, :country, :party)
      query = chain_query(query, :country, Country, country)
      query = chain_query(query, :election, Election, election)
      chain_query(query, :party, Party, party)
    end

    private

    def chain_query(query, relation_name, relation, relation_option)
      if relation_option
        query = query.joins(relation_name)
        query = query.merge(relation.named(relation_option[:name])) if relation_option[:name]
      end
      query
    end
  end
end
