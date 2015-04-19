class RespondersController < ApplicationController
  def index
    render json: Responder.capacities if params[:show] == 'capacity'
    @responders = Responder.all
  end

  def show
    set_responder
  end

  def create
    @responder = Responder.new(create_params)

    if @responder.save
      render :show, status: :created, location: responder_url(@responder)
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  end

  def update
    set_responder
    if @responder.update(update_params)
      render :show, status: :ok, location: responder_url(@responder)
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_responder
    @responder = Responder.find_by!(name: params[:name])
  end

  def responder_params
    params.require(:responder)
  end

  def create_params
    responder_params.permit(:type, :name, :capacity)
  end

  def update_params
    responder_params.permit(:on_duty)
  end
end
