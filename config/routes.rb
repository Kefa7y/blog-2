Rails.application.routes.draw do
  get 'users/new'

  get 'session/new'

  get 'users/show'

  get 'posts/index'

  get 'posts/edit'

  get 'posts/new'

  get 'posts/show'

  post 'posts/create'

  post 'posts/update'

  post 'posts/destroy'

  post 'session/create'

  post 'users/create'

  post 'session/destroy'

  post 'comments/create'

  post 'comments/update'

  post 'comments/destroy'

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
