class BusesController < ApplicationController
 #common methods for customer and bus owner are listed here 
 
  def index
    @buses = Bus.all
  end

  # GET /buses/1 or /buses/1.json
  def show
    @buses = Bus.all.pluck(:id)
    puts(@buses)
    if(@buses.include?(params[:id].to_i) == false)
      flash[:alert] = "Bus Not Found"
      redirect_back(fallback_location: root_path)
    else
      set_bus
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    
end
