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
    before(:context) do
      @queried_name = "query"
      @queried_after = "2010-01-01"
      @queried_before = "2015-01-01"
      @matching_date = "2011-01-01"
      @wrong_date_after = "2009-01-01"
      @wrong_date_before = "2016-01-01"
      @matching_name = "XX#{@queried_name}XX"
      @matching_election = create(:election, name: @matching_name, date: @matching_date)
      @matching_party = create(:party, name: @matching_name)
      @matching_country = create(:country, name: @matching_name)
    end

    def create_result_with_matching_election_name
      create(:election_result, election: @matching_election)
    end

    def create_result_with_matching_party_name
      create(:election_result, party: @matching_party)
    end

    def create_result_with_matching_country_name
      create(:election_result, country: @matching_country)
    end

    def create_result_with_matching_date(wrong_date)
      wrong_election = create(:election, date: wrong_date)
      create(:election_result, election: wrong_election)
      create(:election_result, election: @matching_election)
    end

    def create_matching_all_result
      wrong_election_1 = create(:election, date: @matching_date)
      wrong_election_2 = create(:election, name: @matching_name)
      create(:election_result, election: wrong_election_1, country: @matching_country,
                               party: @matching_party)
      create(:election_result, election: wrong_election_2, country: @matching_country,
                               party: @matching_party)
      create(:election_result, election: @matching_election, party: create(:party, name: @matching_name))
      create(:election_result, election: @matching_election, country: @matching_country)
      create(:election_result, election: @matching_election, country: @matching_country,
                               party: create(:party, name: @matching_name))
    end
    describe "with no date query" do
      before(:example) do
        create(:election_result)
      end
      it "return election results with matching election name" do
        matching_result = create_result_with_matching_election_name
        expect(described_class.of({ election: { name: @queried_name } }))
          .to contain_exactly(matching_result)
      end
      it "return election results with matching party name" do
        matching_result = create_result_with_matching_party_name
        expect(described_class.of({ party: { name: @queried_name } }))
          .to contain_exactly(matching_result)
      end
      it "return election results with matching country name" do
        matching_result = create_result_with_matching_country_name
        expect(described_class.of({ country: { name: @queried_name } }))
          .to contain_exactly(matching_result)
      end
    end
    it "return election results after a date" do
      matching_result = create_result_with_matching_date(@wrong_date_after)
      expect(described_class.of({ after: @queried_after }))
        .to contain_exactly(matching_result)
    end
    it "return election results before a date" do
      matching_result = create_result_with_matching_date(@wrong_date_before)
      expect(described_class.of({ before: @queried_before }))
        .to contain_exactly(matching_result)
    end
    it "return election results with matching country, election, party name and period" do
      matching_result = create_matching_all_result
      expect(described_class.of({
                                  country: { name: @queried_name },
                                  election: { name: @queried_name },
                                  party: { name: @queried_name },
                                  after: @queried_after,
                                  before: @queried_before
                                }))
        .to contain_exactly(matching_result)
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
