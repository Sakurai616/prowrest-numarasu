Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'static_pages#top'

  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create] do
    resources :do_questions, only: %i[index show]
  end

  resource :profile, only: %i[show edit update]

  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get 'search'
    end
  end

  resources :likes, only: %i[create destroy]
  resources :questions do
    get 'correct_result', to: 'questions#correct_result'
    get 'wrong_result', to: 'questions#wrong_result'
    collection do 
      get 'search'
    end
  end

  resources :chat_groups
end
