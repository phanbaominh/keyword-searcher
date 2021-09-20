# frozen_string_literal: true

class Party < ApplicationRecord
  belongs_to :country
  has_many :election_results, dependent: :nullify
end
