Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show]
      resources :boards, except: %i[show] do
        resources :tasks, except: %i[show] do
          resource :status, only: %i[update], controller: "tasks/status"
        end
      end
    end
  end
end
