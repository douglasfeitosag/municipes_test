class AddressDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper

  delegate_all

  def zipcode
    object.zipcode.gsub(/(\d{5})(\d{3})/, '\1-\2)')
  end

  def state
    object.state.name
  end

  def city
    object.city.name
  end
end
