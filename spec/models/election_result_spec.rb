# frozen_string_literal: true

# https://github.com/thoughtbot/shoulda-matchers
require 'rails_helper'

RSpec.describe ElectionResult, type: :model do
  subject { build(:election_result) }
  it { should validate_numericality_of(:votes).is_greater_than_or_equal_to(0) }
  it do
    should validate_uniqueness_of(:party).scoped_to(:election_id)
                                         .with_message("should have only one result per election")
  end
  describe ".of_election" do
    it "returns results of an election" do
      elections = []
      3.times { elections << create(:election) }
      first_election = elections[0]
      results = []
      2.times { results << create(:election_result, election: first_election) }
      expect(described_class.of_election(first_election)).to contain_exactly(*results)
    end
  end
  # specify "A party should only have one result per election" do
  #   election = create(:election)
  #   party = create(:party)
  #   expect do
  #     2.times { create(:election_result, election: election, party: party) }
  #   end.to raise_error(ActiveRecord::RecordInvalid, /one result per election/)
  # end
end
