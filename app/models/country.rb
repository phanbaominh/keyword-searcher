# frozen_string_literal: true

class Country < ApplicationRecord
  include Nameable

  has_many :parties, dependent: :nullify
  has_many :elections, dependent: :nullify
  has_many :election_results, dependent: :nullify
end
