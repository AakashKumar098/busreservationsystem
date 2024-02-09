module ReservationHelper

    def CheckSeatIsBooked?(seatno,bus_id,d_o_j)
        bus = Bus.find(bus_id)
        reservations = bus.reservations.where(dateofjourney:d_o_j)
        # finding specific bus seat status
        reservations.each do|res|
            seats = res.travellers
            seats.each do |seat|
                if seat.seat_id == seatno
                    return true 
                end
            end
        end
        return false 
    end
    
end
