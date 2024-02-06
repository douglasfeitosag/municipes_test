module ApplicationHelper
  def errors_for(f, field)
    f.object.errors[field].map do |error|
      tag.p(error, class: 'text-red-700')
    end.join.html_safe
  end

  def color_classes(type)
    case type.to_sym
    when :success
      'bg-green-100 border-green-400 text-green-700'
    when :alert
      'bg-red-100 border-red-400 text-red-700'
    when :warning
      'bg-yellow-100 border-yellow-400 text-yellow-700'
    when :notice
      'bg-blue-100 border-blue-400 text-blue-700'
    else
      'bg-gray-100 border-gray-400 text-gray-700'
    end
  end
end
