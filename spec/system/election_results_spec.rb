# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Viewing election results", type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  scenario "Viewing result of an election" do
    election = create(:election)
    results = []
    5.times { results << create(:election_result, election: election) }
    visit '/'
    within(".query") do
      fill_in 'Election', with: election.name
      click_button 'Query'
    end
    expect(page).to have_selector("canvas")
    # expect(page).to have_text("#{election.name} result")
    # results.each do |result|
    #   expect(page).to have_text(result.party.name)
    # end
  end
end
