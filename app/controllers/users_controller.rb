class UsersController < ApplicationController
    before_action :authenticate_user! ,only: %i[showmyallreservation showmyallbus]


    def showmyallbus
        @buses = current_user.buses
    end

    def profile
        
    end

    def showmyallreservation
        @currentuserres = current_user.reservations
        #puts(@currentuserres)
    end
    


end