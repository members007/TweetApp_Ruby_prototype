Rails.application.routes.draw do
  get  'posts/index'
  get  'posts/new' => "posts#new"
  post 'posts/create' => "posts#create"
  get  'posts/:id' => "posts#show"
  get  'posts/:id/edit' => "posts#edit"
  post 'posts/:id/update' => "posts#update"
  post 'posts/:id/destroy' => "posts#destroy"

  post 'likes/:post_id/like' => "likes#like"
  post 'likes/:post_id/unlike' => "likes#unlike"
  
  
  get  'users/index'
  get  'login' => "users#login_form"
  get  'users/:id/show' => "users#show"
  get  'users/:id/likes' => "users#likes"
  get  'signup' => "users#new"
  post 'users/create' => "users/create"
  get  'users/:id/edit' => "users#edit"
  post 'users/:id/update' => "users#update"
  post 'login' => "users#login"
  post 'logout' => "users#logout"

  get '/' => "home#top"
  get 'top/about' => "home#about"
end
