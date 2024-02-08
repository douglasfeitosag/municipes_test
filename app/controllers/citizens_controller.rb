class CitizensController < ApplicationController
  def data
    @citizens = Citizen.search(search_params[:q]).collect { |c| [c.id, c.name, c.cpf, c.email] }

    render layout: false, partial: "components/table/rows", locals: { rows: @citizens }
  end

  def cities
    @cities = City.where(city_params).collect { |c| [c.name, c.id] }

    render layout: false, partial: "components/form/select", locals: { name: "citizen[address_attributes][city_id]", collection: @cities, selected: nil, attrs: {} }
  end

  def new
    @citizen = Citizen.new
    @states = State.all.collect { |c| [c.name, c.id] }
    @cities = []
  end

  def create
    @citizen = Citizen.new(citizen_params)

    service = CitizenCreateService.new(citizen_params)
    result = service.call

    if result[:success]
      redirect_to citizens_path, notice: t("messages.success.created")
    else
      @states = State.all.collect { |c| [c.name, c.id] }
      @cities = City.where(state_id: @citizen.state_id).collect { |c| [c.name, c.id] }

      render :new
    end
  end

  def edit
    @citizen = Citizen.find(params[:id])
    @states = State.all.collect { |c| [c.name, c.id] }
    @cities = City.where(state_id: @citizen.address.state_id).collect { |c| [c.name, c.id] }
  end

  def update
    @citizen = Citizen.find(params[:id])

    service = CitizenUpdateService.new(@citizen, citizen_params)
    result = service.call

    if result[:success]
      redirect_to citizens_path, notice: t("messages.success.saved")
    else
      render :edit
    end
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name, :email, :cpf, :cns, :phone, :birthdate, :active, address_attributes: [
      :id, :state_id, :city_id, :zipcode, :street, :neighbourhood, :ibge_code])
  end

  def city_params
    params.permit(:state_id)
  end

  def search_params
    params.permit(:q)
  end
end
