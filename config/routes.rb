AngularBook::Application.routes.draw do
	resources :todos, except: [:new, :edit]

  match "*path", to: "todos#index", via: "get"

  root 'todos#index'
end
