# frozen_string_literal: true

FactoryBot.define do
  factory :election_result do
    election
    party
    votes { 1 }
    seats { 1 }
    votes_percent_diff { 1.5 }
    seats_diff { 1 }
  end
end
