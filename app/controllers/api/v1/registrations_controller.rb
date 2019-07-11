class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exit, only: :create
  #sign_up
  def create
    @user = User.new(user_params)
    if user.save
      json_response "Signed up successfully", true, {user: @user.select(:email, :id, :authentication_token)}, :ok
    else
      json_response "Something Wrong", false, {}, :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exit
    return if params[:user].present?
    json_response "Missing Params", false, {}, :bad_request
  end

end