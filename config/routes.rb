Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/driver/register', to: 'drivers#register'
      post '/driver/:id/sendLocation/', to: 'drivers#send_location', as: 'driver'
      post '/passenger/available_cabs/', to: 'drivers#available_cabs'
    end
  end
end
