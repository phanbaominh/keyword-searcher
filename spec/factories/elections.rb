# frozen_string_literal: true

FactoryBot.define do
  factory :election do
    sequence(:name) { |n| "Election_#{n}" }
    date { "2021-09-20" }
    country
    has_seats { false }
  end
end
