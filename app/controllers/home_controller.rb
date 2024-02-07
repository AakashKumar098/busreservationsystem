class HomeController < ApplicationController
    
    def index
        @buses = Bus.all
    end

    def busownerhome
        
    end

    def customerhome

    end

    def search
        if(params[:source] != "" && params[:destination] == "")
            @buses = Bus.where(source_route:params[:source])
        elsif(params[:source] == "" && params[:destination] != "")
            @buses = Bus.where(destination_route:params[:destination])
        else
            @buses = Bus.where(source_route:params[:source]).where(destination_route:params[:destination])
        end
        if(@buses.size == 0 )
            flash[:alert] = "Please Enter valid Source or destination"
        end
        render "home/index"
    end

    def searchbybusname
        @buses = Bus.where(busname:params[:bus_name])
        if(@buses.size == 0 )
            flash[:alert] = "Please Enter valid busname "
        end
        render "home/index"
    end


end

