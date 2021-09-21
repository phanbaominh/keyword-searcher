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

  describe ".of" do
    before(:example) do
      queried_election_name = "XQuery Election"
      queried_party_name = "XQuery Party"
      queried_country_name = "XQuery Country"
      @queried_name = "Query"
      country_1 = create(:country, name: queried_country_name)
      country_2 = create(:country)
      election_1 = create(:election, country: country_1, name: queried_election_name)
      election_2 = create(:election, country: country_1)
      election_3 = create(:election, country: country_2, name: queried_election_name)
      party_1 = create(:party, country: country_1, name: queried_party_name)
      party_2 = create(:party, country: country_1)
      party_3 = create(:party, country: country_2)
      @result_1 = create(:election_result, party: party_1, election: election_1, country: country_1)
      @result_2 = create(:election_result, party: party_2, election: election_1, country: country_1)
      @result_3 = create(:election_result, party: party_1, election: election_2, country: country_1)
      @result_4 = create(:election_result, party: party_3, election: election_3, country: country_2)
    end
    # { elections: {election:, result:}, parties: {party:, result:}}
    it "return election results with queried election name" do
      expect(described_class.of({ election: { name: @queried_name } }))
        .to contain_exactly(@result_1, @result_2, @result_4)
    end
    it "return election results with queried party name" do
      expect(described_class.of({ party: { name: @queried_name } }))
        .to contain_exactly(@result_1, @result_3)
    end
    it "return election results with queried country name" do
      expect(described_class.of({ country: { name: @queried_name } }))
        .to contain_exactly(@result_1, @result_2, @result_3)
    end
    it "return election results with queried country, election, party name" do
      expect(described_class.of({
                                  country: { name: @queried_name },
                                  election: { name: @queried_name },
                                  party: { name: @queried_name }
                                }))
        .to contain_exactly(@result_1)
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
