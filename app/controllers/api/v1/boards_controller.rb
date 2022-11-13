module Api
  module V1
    class BoardsController < BaseController
      def create
        board = Board.new(board_params.merge(user: current_user))

        if board.save!
          render json: { mesagge: "Board created successsfully" }, status: :ok
        else
          render json: { message: "Board cannot be created.", errors: board.errors.full_messages },
            status: :unprocessable_entity
        end
      end

      def index
        render json: { boards: boards }, status: :ok
      end

      def update
        if board.update board_params
          render json: { message: "Board updated successfully" }, status: :ok
        else
          render json: { message: "Board cannot be updated.", errors: board.errors.full_messages },
            status: :unprocessable_entity
        end
      end

      def destroy
        if board
          board.delete
          render json: { message: "Board deleted successfully" }, status: :ok
        else
          render json: { message: "Board not found" }, status: :unprocessable_entity
        end
      end

      private

      def board
        @board ||= Board.find_by id: params[:id]
      end

      def boards
        @boards ||= current_user.boards
      end

      def board_params
        params.require(:board).permit :name
      end
    end
  end
end
