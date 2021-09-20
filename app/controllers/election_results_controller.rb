# frozen_string_literal: true

class ElectionResultsController < ApplicationController
  def index
    render json: { data: [{ name: "Labour Party", votes: 760_855, seats: 48, seats_diff: -1,
                            votes_percent_diff: -1.0 }] }
  end
end
