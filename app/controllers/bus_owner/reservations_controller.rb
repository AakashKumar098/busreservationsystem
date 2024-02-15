class BusOwner::ReservationsController < ApplicationController
    before_action :authenticate_user! ,only: %i[index]
    def index
        bus = Bus.find(params[:bus_id])
        d_o_j = params[:bus][:dateofjourney]
        puts("dateofjourney= #{d_o_j}")
        if(d_o_j== "")
            #puts("hello")
            @reservations = bus.reservations.where('dateofjourney >= ?', Date.today)
        else
            @reservations = bus.reservations.where(dateofjourney:d_o_j)
        end
    end
    private
        def set_bus
            @bus = Bus.find(params[:bus_id])
        end
end