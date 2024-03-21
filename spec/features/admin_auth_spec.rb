# frozen_string_literal: true

require "rails_helper"

describe "Administrative suite is hidden behind authorization" do
  include_context 'devise'

  [
    "/admin",
    "/changes",
    "/events/duplicates",
    "/venues/duplicates"
  ].each do |path|
    it "Visitors are not permitted in #{path}" do
      begin
        visit path
      rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
        expect(page).to have_content('Access denied')
      end
    end

    it "Authorized users are permitted in #{path}" do
      devise_sign_in create(:admin)
      visit path
      expect([200, 304]).to include page.status_code
    end

    it "Un-authorized users are not permitted in #{path}" do
      devise_sign_in create(:user)
      visit path
      expect([403]).to include page.status_code
    end
  end
end
