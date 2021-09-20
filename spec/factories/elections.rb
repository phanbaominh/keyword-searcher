# frozen_string_literal: true

FactoryBot.define do
  factory :election do
    name { "MyString" }
    date { "2021-09-20" }
    country { nil }
    has_seats { false }
  end
end
