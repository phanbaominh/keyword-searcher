# frozen_string_literal: true

class CreateElectionResults < ActiveRecord::Migration[6.1]
  def change
    create_table :election_results do |t|
      t.references :election, null: false, foreign_key: true
      t.references :party, null: false, foreign_key: true
      t.integer :votes
      t.integer :seats
      t.float :votes_percent_diff
      t.integer :seats_diff

      t.timestamps
    end
  end
end
