# frozen_string_literal: true

class AddIndexToElectionResults < ActiveRecord::Migration[6.1]
  def change
    add_index :election_results, %i[party_id election_id], unique: true
  end
end
