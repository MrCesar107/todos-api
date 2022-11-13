module Api
  module V1
    module Tasks
      class StatusController < ::Api::V1::TasksController
        STATUSES = %W[unstarted started done].freeze

        def update
          if STATUSES.include? task_params[:status]
            if task && task.update(status: task_params[:status])
              render json: { message: "Task status updated successfully." }, status: :ok
            else
              render json: { message: "Task not found.", errors: task&.errors&.full_messages },
                status: :unprocessable_entity
            end
          else
            render json: { message: "Invalid status." }, status: :unprocessable_entity
          end
        end

        private

        def task
          @task ||= Task.find_by id: params[:task_id]
        end

        def task_params
          params.require(:task).permit(:status)
        end
      end
    end
  end
end
