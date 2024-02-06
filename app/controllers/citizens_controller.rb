class CitizensController < ApplicationController
  def data
    @citizens = Citizen.all.collect { |c| [c.id, c.name, c.email] }

    render layout: false, partial: "components/table/rows", locals: { rows: @citizens }
  end

  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      redirect_to citizens_path, notice: t("devise.omniauth_callbacks.success")
    else
      render :new
    end
  end

  private

  def citizen_params
    params.require(:citizen).permit(:name, :email, :cpf, :cns, :birthdate)
  end
end
