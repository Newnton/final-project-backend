Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/buildings/:address', to: 'building#show'
      get '/buildings', to: 'building#index'
      get '/boroughs', to: 'building#borough_totals'
    end
  end
end
