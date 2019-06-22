Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'amadeus_data', to: 'api#amadeus_data', as: 'amadeus_data'
end
