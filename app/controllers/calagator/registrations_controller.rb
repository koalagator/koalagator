module Calagator
  class RegistrationsController < Devise::RegistrationsController
    before_action -> { devise_parameter_sanitizer.permit(:sign_up, keys: %i[name]) }, only: :create
  end
end
