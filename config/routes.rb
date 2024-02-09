Rails.application.routes.draw do

  resources :buses do
    resources :reservations
  end

  get "buses/:bus_id/choosedate" => "reservations#choosedate", as: :choose_date
  get "buses/:bus_id/buschoosedate" => "buses#choosedate", as: :bus_choose_date
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "busowner" => "home#busownerhome"

  get "customer" => "home#customerhome"

  get "myallbuses" => "users#showmyallbus"

  get "allbuses"  => "bus#index"

  get "showusersprofile" => "users#profile"

  get "showmyallreservations" => "users#showmyallreservation" ,as: :showmyallreservation


  # Defines the root path route ("/")

  get "searchbus" => "home#search"

  get "searchbybusname" => "home#searchbybusname"

  get "home" => "home#index"

  get "showavalseats" => "buses#showavalseats" ,as: :showavalseats
  
end
