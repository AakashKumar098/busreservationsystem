class TravellersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @trav = Traveller.where(reservation_id:params[:reservation_id])
    end


    def bulk_delete_travellers
        #fail
        respond_to do|format|
            res = Reservation.find(params[:reservation_id])
            selected_travellers = res.travellers.where(id:params[:trav_ids])
            selected_travellers.delete_all 
            if(res.travellers.count == 0)
                res.destroy!
                flash[:alert] = "Reservation deleted Successfully"
            else
                flash[:alert] = "All Selected travellers Deleted "
            end
            format.js
          end

    end


end