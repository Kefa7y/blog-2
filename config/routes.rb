Rails.application.routes.draw do
  get 'users/signup'

  get 'users/login'

  get 'users/profile'

  get 'posts/index'

  get 'posts/edit'

  get 'posts/new'

  get 'posts/show'

  post 'posts/create'

  post 'posts/update'

  post 'posts/destroy'

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
