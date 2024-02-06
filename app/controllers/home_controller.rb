class HomeController < ApplicationController
    
    def index
        @buses = Bus.all
    end

    def busownerhome
        
    end

    def customerhome

    end

    def search
        @buses = Bus.where(source_route:params[:source]).where(destination_route:params[:destination])
        render "home/index"
    end

    def searchbybusname
        @buses = Bus.where(busname:params[:bus_name])
        render "home/index"
    end


end

