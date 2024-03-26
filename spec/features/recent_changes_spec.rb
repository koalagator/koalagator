# frozen_string_literal: true

require "rails_helper"

describe "Recent Changes", js: true do
  include_context 'devise'
  let(:event_title) { "The Newest Event" }

  before do
    create :event, title: event_title, start_time: Time.zone.now
    devise_sign_in create(:admin)
  end

  it "An admin user browses recent changes" do
    visit "/changes"

    expect(page).to have_content(/create/i)
    expect(page).to have_content event_title
  end

  it "An admin user fetches the recent changes feed" do
    visit "/changes"
    click_on "Changes feed"

    expect(page.body).to have_content(/create/i)
    expect(page.body).to have_content event_title
  end
end
