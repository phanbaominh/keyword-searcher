# frozen_string_literal: true

class ElectionResult < ApplicationRecord
  belongs_to :election
  belongs_to :party

  validates :votes, numericality: { greater_than_or_equal_to: 0 }
  validates :party, uniqueness: { scope: :election_id, message: "should have only one result per election" }

  scope :of_election, ->(election) { where(election: election) }
end
