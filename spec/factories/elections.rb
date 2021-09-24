# frozen_string_literal: true

FactoryBot.define do
  factory :election do
    transient do
      start_year { 2000 }
    end
    sequence(:name) { |n| "Election_#{n}" }
    sequence(:date) { |n| "#{start_year + n}-09-20" }
    country
    has_seats { false }
  end
end
