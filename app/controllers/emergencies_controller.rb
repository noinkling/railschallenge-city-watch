class EmergenciesController < ApplicationController
  def index
    @emergencies = Emergency.all
  end

  def show
    set_emergency
  end

  def create
    @emergency = Emergency.new(create_params)
    if @emergency.save
      @emergency.dispatch_responders
      render :show, status: 201, location: @emergency
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  def update
    set_emergency
    if @emergency.update(update_params)
      @emergency.update_dispatch
      render :show, status: 200, location: @emergency
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  private

  def set_emergency
    @emergency = Emergency.find_by!(code: params[:code])
  end

  def emergency_params
    params.require(:emergency)
  end

  def create_params
    emergency_params.permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def update_params
    emergency_params.permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end
end
