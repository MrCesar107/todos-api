module Api
  module V1
    class TasksController < BaseController
      def create
        task = Task.new task_params.merge board: board

        if task.save!
          render json: { message: "Task created successfully" }, status: :ok
        else
          render json: { message: "Task cannot be created.", errors: task.errors.full_messages },
            status: :unprocessable_entity
        end
      end

      def index
        render json: { tasks: tasks }, status: :ok
      end

      def update
        if task&.update task_params
          render json: { message: "Task updated successfully" }, status: :ok
        else
          render json: { message: "Task cannot be updated.", errors: task&.errors&.full_messages },
            status: :unprocessable_entity
        end
      end

      def destroy
        if task
          task.delete
          render json: { message: "Task deleted successfully" }, status: :ok
        else
          render json: { message: "Task not found" }, status: :unprocessable_entity
        end
      end

      private

      def board
        @board ||= Board.find params[:board_id]
      end

      def tasks
        board.tasks
      end

      def task
        @task ||= Task.find_by id: params[:id]
      end

      def task_params
        params.require(:task).permit(:title, :description, :status)
      end
    end
  end
end
