# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "ElectionResults", type: :request do
  describe "GET /" do
    it "returns result of an election" do
      query_data = { election: "Norway 2021 legislative election" }
      get "/election_results?#{query_data.to_query}"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("json")
      res_json = JSON.parse(response.body)
      expect(res_json.values).to include be_a_kind_of(Array).and all an_object_matching(
        "name" => be_an_instance_of(String),
        "votes" => be_an_instance_of(Integer),
        "seats" => be_an_instance_of(Integer),
        "votes_percent_diff" => be_an_instance_of(Float),
        "seats_diff" => be_an_instance_of(Integer)
      )
    end
  end
end
