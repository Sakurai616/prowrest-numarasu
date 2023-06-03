Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'questions#index'

  get 'about', to: 'static_pages#about'
  get 'term', to: 'static_pages#term'
  get 'privacy', to: 'static_pages#privacy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create] 

  resource :profile, only: %i[show edit update]

  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'search'
      get 'organization_search'
    end
  end

  resources :likes, only: %i[create destroy]
  resources :questions do
    collection do 
      get 'search'
    end
    get 'result', to: 'question_answers#result'
  end

  resources :chat_groups do
    get 'join', to: 'chat_groups#join'
    delete 'leave', to: 'chat_groups#leave'
    collection do
      get 'search'
    end
    resources :messages, only: %i[create]
  end
  mount ActionCable.server => '/cable'
end
