# frozen_string_literal: true

class Election < ApplicationRecord
  include Nameable

  belongs_to :country
  has_many :election_results, dependent: :destroy
end
