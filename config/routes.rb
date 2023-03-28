Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create] do
    resources :do_questions, only: %i[index show]
  end

  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
  end

  resources :likes, only: %i[create destroy]
  resources :questions do
    resources :choices, only: %i[new create edit update destroy], shallow: true
    get 'correct_result', to: 'questions#correct_result'
    get 'wrong_result', to: 'questions#wrong_result'
  end

  resources :chat_groups
end
