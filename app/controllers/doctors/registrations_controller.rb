class Doctors::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :full_name, :speciality_id, :clinic_name, :phone, :start_time, :end_time])
  end
end
