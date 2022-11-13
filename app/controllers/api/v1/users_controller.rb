module Api
  module V1
    class UsersController < BaseController
      def show
        render json: { user: user }, status: :ok
      end

      private

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
