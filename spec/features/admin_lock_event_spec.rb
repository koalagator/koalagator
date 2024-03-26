# frozen_string_literal: true

require "rails_helper"

describe "Event locking", js: true do
  include_context "devise"

  before do
    create :venue, title: "Empire State Building"
    create :event, title: "Ruby Newbies", start_time: Time.zone.now
    create :event, title: "Ruby Privateers", start_time: Time.zone.now, locked: true

    devise_sign_in create(:admin)

    visit "/admin"
    click_on "Lock events"
  end

  it "Admin locks an event to prevent it from being modified" do
    within "tr", text: "Ruby Newbies" do
      click_on "Lock"
    end

    expect(page).to have_content("Locked event Ruby Newbies")
    click_on "Ruby Newbies"

    expect(page).to have_content("This event is currently locked and cannot be edited.")
    expect(page).not_to have_selector("a", text: "edit")
    expect(page).not_to have_selector("a", text: "delete")
  end

  it "Admin unlocks a locked event" do
    within "tr", text: "Ruby Privateers" do
      click_on "Unlock"
    end

    expect(page).to have_content("Unlocked event Ruby Privateers")
    click_on "Ruby Privateers"

    expect(page).not_to have_content("This event is currently locked and cannot be edited.")
    expect(page).to have_selector("a", text: "edit")
    expect(page).to have_selector("a", text: "delete")
  end
end
