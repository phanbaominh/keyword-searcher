# frozen_string_literal: true

class Party < ApplicationRecord
  include Nameable

  belongs_to :country
  has_many :election_results, dependent: :nullify
end
