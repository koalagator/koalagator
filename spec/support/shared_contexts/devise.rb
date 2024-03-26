shared_context "devise" do
  # https://stackoverflow.com/questions/32368463/how-signin-via-devise-and-capybara
  def devise_sign_in(user, options = {})
    email = options[:email] || user.email
    password = options[:password] || user.password
    # Do login with new, valid user account
    visit "/users/sign_in"
    fill_in "user_email", with: email
    fill_in "user_password", with: password, exact: true
    click_button "Log in"
  end
end
