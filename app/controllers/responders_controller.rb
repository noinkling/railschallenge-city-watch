class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :update]

  # GET /responders
  # GET /responders.json
  def index
    if params[:show] == 'capacity'
      # TODO: Work out what to put here
    end
    @responders = Responder.all
  end

  # GET /responders/1
  # GET /responders/1.json
  def show
  end

  # POST /responders
  # POST /responders.json
  def create
    @responder = Responder.new(create_responder_params)

    if @responder.save
      render :show, status: :ok, location: responder_url(@responder)
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
  rescue ActionController::UnpermittedParameters => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /responders/1
  # PATCH/PUT /responders/1.json
  def update
    if @responder.update(update_responder_params)
      render :show, status: :ok, location: responder_url(@responder)
    else
      render json: @responder.errors, status: :unprocessable_entity
    end
  rescue ActionController::UnpermittedParameters => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  # DELETE /responders/:name
  # DELETE /responders/:name.json
  def destroy
    render_404
  end

  # GET /responders/new
  # GET /responders/new.json
  def new
    render_404
  end

  # GET /responders/:name/edit
  # GET /responders/:name/edit.json
  def edit
    render_404
  end

  private

  def set_responder
    @responder = Responder.find_by(name: params[:name])
    render_404 unless @responder
  end

  def create_responder_params
    params.require(:responder).permit(:type, :name, :capacity)
  end

  def update_responder_params
    params.require(:responder).permit(:on_duty)
  end

  def render_404
    render json: { message: 'page not found' }, status: 404
  end
end
