# frozen_string_literal: true

class AddCountryReferencesToElectionResult < ActiveRecord::Migration[6.1]
  def change
    add_reference :election_results, :country, null: false, foreign_key: true
  end
end
