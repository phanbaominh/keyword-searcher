# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :parties, dependent: :nullify
  has_many :elections, dependent: :nullify
end
