# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ElectionResults", type: :request do
  describe "GET /search" do
    it "returns result of an election" do
      election = create(:election)
      3.times { create(:election_result, election: election) }
      2.times { create(:election_result) }
      query_data = { election: { name: election.name } }
      get "/election_results/search?#{query_data.to_query}"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("json")
      res_json = JSON.parse(response.body)
      expect(res_json.size).to eq(3)
      expect(res_json).to be_a_kind_of(Array).and all a_hash_including(
        "election" => a_hash_including(*Election.column_names),
        "party" => a_hash_including(*Party.column_names),
        "country" => a_hash_including(*Country.column_names),
        "votes" => be_an_instance_of(Integer),
        "seats" => be_an_instance_of(Integer),
        "votes_percent_diff" => be_an_instance_of(Float),
        "seats_diff" => be_an_instance_of(Integer)
      )
    end
  end
end
