# frozen_string_literal: true

class Election < ApplicationRecord
  belongs_to :country
  has_many :election_results, dependent: :destroy
end
