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
        if(params[:source] != "" && params[:destination] != "" && params[:bus_name] != "")
            @buses = Bus.where(source_route:params[:source]).where(destination_route:params{:destination}).where(busname:params[:bus_name])
        elsif(params[:source] != "" && params[:destination] != "" && params[:bus_name] == "")
            @buses = Bus.where(source_route:params[:source]).where(destination_route:params[:destination])
        elsif(params[:source] != "" && params[:destination] == "" && params[:bus_name] != "")
            @buses = Bus.where(source_route:params[:source]).where(busname:params[:bus_name])
        elsif(params[:source] == "" && params[:destination] != "" && params[:bus_name] != "")
            @buses = Bus.where(destination_route:params[:destination]).where(busname:params[:bus_name])
        elsif(params[:source] != "" && params[:destination] == "" && params[:bus_name] == "")
            @buses = Bus.where(source_route:params[:source])
        elsif(params[:source] == "" && params[:destination] != "" && params[:bus_name] == "")
            @buses = Bus.where(destination_route:params[:destination])
        elsif(params[:source] == "" && params[:destination] == "" && params[:bus_name] != "")
            @buses = Bus.where(busname:params[:bus_name])
        else
            @buses = Bus.all
        end
        if(@buses.size == 0 )
            flash[:alert] = "Please Enter valid value"
        end
        @seataval = []
        @buses.each do|bus|
            puts("date of journey #{params[:dateofjourney]}")
            @res = bus.reservations.where(dateofjourney:params[:dateofjourney])
            if(@res.count == 0 )
                @seataval <<  bus.noofseat
            else
                noofseatbooked = 0 
                @res.each do|r|
                    noofseatbooked += r.travellers.count
                end
                @seataval << (bus.noofseat - noofseatbooked)
            end
        end
        puts(@seataval)
        #fail
        render "home/index"
    end


end

