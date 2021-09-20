# frozen_string_literal: true

class CreateElections < ActiveRecord::Migration[6.1]
  def change
    create_table :elections do |t|
      t.string :name
      t.date :date
      t.references :country, null: false, foreign_key: true
      t.boolean :has_seats

      t.timestamps
    end
  end
end
