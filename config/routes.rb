Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'dice#home'
  get '/home', to: 'dice#home'
  get '/roll', to: 'dice#roll'
end
