class ReservationsController < ApplicationController

    before_action :set_bus ,only: %i[create  show destroy choosedate]
    before_action :authenticate_user! ,only: %i[create  destroy  choosedate]
    
    def new
        @bus = Bus.find(params[:bus_id])
        @reservation = Reservation.new
    end

    def index
        #fail
        bus = Bus.find(params[:bus_id])
        d_o_j = params[:bus][:dateofjourney]
        #puts("dateof journey is =  #{d_o_j}")
        @reservations = bus.reservations.where(dateofjourney:d_o_j)
    end

    def create
        #fail
        #variable to check whether error occured or not during reservation
        errorduringres = 0 
        dateofjourney = params[:reservation][:dateofjourney]
        puts(params[:dateofjourney])
        selected_seats1 = params[:reservation][:selected_seats]
        if (selected_seats1.present? == false )
            flash[:alert]= "Please select more than 0 seats"
            redirect_back(fallback_location: root_path)
            return 
        end
        current_bus_reservations = @bus.reservations.where(dateofjourney:dateofjourney) #finding bus all resrvations

        #picking all travellers seat_id those seat which is booked for that date of journey 
        if(current_bus_reservations.size != 0 )
            @booked_seat = current_bus_reservations.joins(:travellers).pluck('travellers.seat_id')
        else
            @booked_seat= []
        end
        @reservation = @bus.reservations.new(user_id:current_user.id,dateofjourney:dateofjourney)
        @reservation.save
        ActiveRecord::Base.transaction do
            selected_seats1.each do|seatno|
                if (@booked_seat.size == 0 || @booked_seat.include?(seatno.to_i) == false)
                    Traveller.create(seat_id:seatno.to_i,reservation_id:@reservation.id)
                    flash[:notice] = "Reservation Done Successfully"
                else
                    @reservation.delete
                    errorduringres = 1 
                    raise ActiveRecord::Rollback  # Rollback the transaction
                end
            end
        end
        if(errorduringres == 0)
            redirect_to "/buses/#{@bus.id}/reservations/#{@reservation.id}"
            return
        else
            flash[:alert] = "You cannot Book Already Booked Seat"
            redirect_back(fallback_location: root_path)
        end
    end

    def choosedate

    end


    def show
        @seatid = []
        travellers = Traveller.where(reservation_id:params[:id])
        travellers.each do|traveler|
            puts("seat_id #{traveler.seat_id}")
            @seatid << traveler.seat_id
        end
        puts("seatno are#{@seatid.size}")
    end

    def destroy
        # findig resevaion whose id is mentioned in routes
        puts("destroy action of res")
        travcoll = Traveller.where(reservation_id:params[:id])

        #deleted all travellers who are under this reservation
        travcoll.delete_all
        #deleted specific registration
        res = Reservation.find(params[:id])
        res.destroy!
        flash[:notice] = "Reservations Deleted Successfully"
        redirect_back(fallback_location: root_path)
    end

    private
        def set_bus
            @bus = Bus.find(params[:bus_id])
        end
end