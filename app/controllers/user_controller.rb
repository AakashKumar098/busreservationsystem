class UserController < ApplicationController

    def showmyallbus
        @buses = current_user.buses
    end

    def profile
        
    end


    


end