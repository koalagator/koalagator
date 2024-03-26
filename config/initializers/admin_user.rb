module Calagator
  Rails.application.config.after_initialize do
    next unless Calagator.devise_enabled
    next unless Calagator.admin_username.present? && Calagator.admin_email.present? && Calagator.admin_password.present?
    next if User.admin.any?
    User.create(
      name: Calagator.admin_username, email: Calagator.admin_email,
      password: Calagator.admin_password, password_confirmation: Calagator.admin_password,
      admin: true
    )
  end
end
