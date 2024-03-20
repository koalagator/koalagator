# frozen_string_literal: true

require "rails_helper"

describe "Administrative suite is hidden behind an http basic auth wall" do
  [
    "/admin",
    "/events/duplicates",
    "/venues/duplicates"
  ].each do |path|
    it "Users are not permitted in #{path}" do
      begin
        visit path
      rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
        expect(page).to have_content('Access denied')
      end
    end

    it "Authenticated users are permitted in #{path}" do
      user = create(:admin)
      visit "/users/sign_in"
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "asdf1234"
      click_on "Log in"
      visit path
      expect([200, 304]).to include page.status_code
    end
  end
end
