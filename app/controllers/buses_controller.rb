class BusesController < ApplicationController
  before_action :set_bus, only: %i[ show edit  update destroy ]
  #before_action :authenticate_user
  before_action :authenticate_user! ,only: %i[ new create edit destroy update]
  # GET /buses or /buses.json
  def index
    @buses = Bus.all
  end

  # GET /buses/1 or /buses/1.json
  def show
  end

  # GET /buses/new
  def new
    @bus = current_user.buses.new
  end

  # GET /buses/1/edit
  def edit
  end

  # POST /buses or /buses.json
  def create
    @bus = current_user.buses.new(bus_params)
    respond_to do |format|
        if @bus.save
          if(@bus.noofseat <= 0)
            flash[:notice]=" No of seat must be Greater than 0 "
            render new_bus_path
            return # so as to prevent double render error 
          end
        @bus.noofseat.times do|seat_no|
          @bus.seats.create!(seat_id:seat_no+1,status:false)
        end
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully created." }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /buses/1 or /buses/1.json
  def update
    respond_to do |format|
      @bus = current_user.buses.find(params[:id])
      if @bus.update(bus_params)
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully updated." }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1 or /buses/1.json
  def destroy
    @bus = current_user.buses.find(params[:id])
    @bus.destroy!

    respond_to do |format|
      format.html { redirect_to buses_url, notice: "Bus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #show reservation of this bus 

  def choosedate
    @bus = Bus.find(params[:bus_id])
  end
  
  def showreservationofbus
    bus = Bus.find(params[:id])
    @res = bus.reservations.where(dateofjourney:d_o_j)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bus_params
      params.require(:bus).permit(:busname, :bus_no, :source_route, :destination_route, :noofseat, :arrival_time,:departuretime, :owner_id)
    end
end
