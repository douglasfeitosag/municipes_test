class CitizenDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper

  delegate_all

  def birthdate
    I18n.l(object.birthdate, locale: 'pt-BR', format: :default)
  end

  def address
    object.address.decorate
  end

  def phone
    object.phone.gsub(/(\+\d{2})(\d{2})(\d{1})(\d{4})(\d{4})/, '\1 (\2) \3 \4-\5')
  end

  def cpf
    CPF.new(object.cpf).formatted
  end

  def active_html
    if object.active?
      content_tag :span do
        content_tag :svg, class: "w-6 h-6 text-gray-800 dark:text-white", aria: { hidden: "true" }, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24" do
          content_tag :path, nil, stroke: "currentColor", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "2", d: "m5 12 4.7 4.5 9.3-9"
        end
      end
    else
      content_tag :span do
        content_tag :svg, class: "w-6 h-6 text-gray-800 dark:text-white", aria: { hidden: "true" }, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24" do
          content_tag :path, nil, stroke: "currentColor", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "2", d: "M6 18 18 6m0 12L6 6"
        end
      end
    end
  end
end
