Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/buildings/address/:address', to: 'building#show_by_address'
      get '/buildings/id/:id', to: 'building#show_by_id'
      get '/buildings', to: 'building#index'
      get '/boroughs', to: 'building#borough_totals'
    end
  end
end
