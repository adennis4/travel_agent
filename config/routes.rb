Rails.application.routes.draw do

  resources :flight_records

  root 'flight_records#new'
end
