Rails.application.routes.draw do

  namespace :bus_owner do
    resources :buses, only: [:new, :create, :edit, :update, :destroy] do
      resources :reservations, only: [:index]
    end
  end

  resources :buses ,only: [:show ,:index] do
    resources :reservations do 
      resources:travellers ,only: [:index]do
        collection do
          delete:bulk_delete_travellers
        end
      end
    end
  end


  get "buses/:bus_id/choosedate" => "reservations#choosedate", as: :choose_date
  
  get "bus_owner/buses/:bus_id/buschoosedate" => "bus_owner/buses#choosedate", as: :bus_choose_date

  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "busowner" => "home#busownerhome"

  get "customer" => "home#customerhome"

  get "myallbuses" => "bus_owner/buses#showmyallbus"

  get "allbuses"  => "bus#index"

  get "showusersprofile" => "users#profile"

  get "showmyallreservations" => "users#showmyallreservation" ,as: :showmyallreservation


  # Defines the root path route ("/")

  get "searchbus" => "home#search"

  get "searchbybusname" => "bushome#searchbybusname"

  get "home" => "home#index"

  get "showavalseats" => "buses#showavalseats" ,as: :showavalseats
  
end
