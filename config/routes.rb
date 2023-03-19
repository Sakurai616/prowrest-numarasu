Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'static_pages#top'

  resources :users, only: %i[new create]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts do
    resources :comments, only: %i[create destroy], shallow: true
  end

  resources :likes, only: %i[create destroy]
  resources :questions do
    resources :choices, only: %i[new create edit update destroy], shallow: true
  end
  resources :take_quizzes, only: %i[index]
end
