# frozen_string_literal: true

FactoryBot.define do
  factory :party do
    sequence(:name) { |n| "Party_#{n}" }
    country
  end
end
