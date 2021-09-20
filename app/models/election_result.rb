# frozen_string_literal: true

class ElectionResult < ApplicationRecord
  belongs_to :election
  belongs_to :party
end
