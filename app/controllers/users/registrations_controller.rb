class Users::RegistrationsController < Devise::RegistrationsController
  before_action :config_sign_up_params, only: [:create]

  protected

  def config_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
