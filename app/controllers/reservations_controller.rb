class ReservationsController < ApplicationController

    before_action :set_bus ,only: %i[create  show destroy choosedate]
    before_action :authenticate_user! ,only: %i[create  destroy  choosedate]
    
    def new
        #fail
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
        #to delete the selected seat from params we have passed this 
        errorduringres = 0 
        dateofjourney = params[:reservation][:dateofjourney]
        puts("Date of Journey #{dateofjourney}")
        selected_seats1 = params[:reservation][:selected_seats]
        if (selected_seats1.present? == false )
            flash[:alert]= "Please select more than 0 seats"
            redirect_back(fallback_location: root_path)
            return 
        end
        #puts("selected seats#{selected_seats1}")
        @reservation = @bus.reservations.new(user_id:current_user.id,bus_id:@bus.id,dateofjourney:dateofjourney)
        @reservation.save
        ActiveRecord::Base.transaction do
            selected_seats1.each do|seatno|
                #puts("hello")
                #puts(seatno)
                s = @bus.seats.find_by(seat_id:seatno)
                puts(@bus.inspect)
                puts(s.inspect)
                if (s.present? && s.status == false)
                    s.status = true 
                    #puts("Hello#{seatno}")
                    s.save

                    Traveller.create(seat_id:seatno,reservation_id:@reservation.id)
                    flash[:notice] = "Reservation Done Successfully"
                    #redirect_to bus_reservation_path(@bus,@reservation)
                else
                    flash[:error] = "Seat #{seatno} not found."
                    @reservation.destroy
                    errorduringres = 1 
                    raise ActiveRecord::Rollback  # Rollback the transaction
                end
            end
        end
        #puts(@reservedseat)
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

        travcoll.each do|trav|
           s = @bus.seats.find_by(seat_id:trav.seat_id)
           s.status = false
           s.save
           #puts("hello seat deleted")
        end
        #deleted all travellers who are under this reservation
        travcoll.destroy_all
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