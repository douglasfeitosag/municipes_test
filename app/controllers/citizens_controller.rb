class CitizensController < ApplicationController
  def data
    @citizens = Citizen.search(search_params[:q]).decorate.collect { |c| [c.id, c.name, c.cpf, c.email] }

    render layout: false, partial: "components/table/rows", locals: { rows: @citizens }
  end

  def cities
    @cities = City.where(city_params).collect { |c| [c.name, c.id] }

    render layout: false,
           partial: "components/form/select",
           locals: {
             object_name: "citizen[address_attributes]",
             name: "city_id",
             collection: @cities,
             selected: nil,
             attrs: {}
           }
  end

  def new
    @citizen = Citizen.new
    @states = State.all.collect { |c| [c.name, c.id] }
    @cities = []
  end

  def create
    @citizen = Citizen.new(citizen_params)

    service = CitizenCreateService.new(@citizen)
    result = service.call

    if result[:success]
      redirect_to citizens_path, notice: t("messages.success.created")
    else
      @states = State.all.collect { |c| [c.name, c.id] }
      @cities = City.where(state_id: @citizen.address.state_id).collect { |c| [c.name, c.id] }

      render :new
    end
  end

  def show
    @citizen = Citizen.find(params[:id]).decorate
  end

  def edit
    @citizen = Citizen.find(params[:id]).decorate
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
      @states = State.all.collect { |c| [c.name, c.id] }
      @cities = City.where(state_id: @citizen.address.state_id).collect { |c| [c.name, c.id] }

      render :edit
    end
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name, :email, :cpf, :cns, :phone, :birthdate, :photo, :photo_cache, :active,
                                    address_attributes: [:id, :state_id, :city_id, :zipcode, :street, :neighbourhood,
                                                         :complement, :ibge_code])
  end

  def city_params
    params.permit(:state_id)
  end

  def search_params
    params.permit(:q)
  end
end
