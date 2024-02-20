class HomeController < ApplicationController

    def index
        @buses = Bus.all
        puts("hello")
        @seataval = []
    end

    def busownerhome
        
    end

    def customerhome

    end

    def search
        #fail
        conditions = {}
        conditions[:source_route] = params[:source].presence if params[:source].present?
        conditions[:destination_route] = params[:destination].presence if params[:destination].present?
        conditions[:busname] = params[:bus_name].presence if params[:bus_name].present?
        #find all buses whose name is this destination is this and source name is this 
        @buses = Bus.where(conditions)
        #fail
        if(@buses.size == 0 )
            flash[:alert] = "Please Enter valid value"
        end
        @seataval = []
        @buses.each do|bus|
            #puts("date of journey #{params[:dateofjourney]}")
            @res = bus.reservations.where(dateofjourney:params[:dateofjourney])
            if(@res.count == 0 )
                @seataval <<  bus.noofseat
            else
                @seataval << (bus.noofseat - @res.joins(:travellers).count)
            end
        end
        #puts(@seataval)
        #fail
        render "home/index"
    end


end

