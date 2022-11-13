# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    render json: { message: "Signed in successfully.", user: current_user }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ").last,
      Rails.application.credentials.devise_jwt_key).first
    current_user = User.find(jwt_payload["sub"])

    if current_user
      render json: { message: "Signed out successfully." }, status: :ok
    else
      render json: { message: "User has not active session" }, status: :unauthorized
    end
  end
end
