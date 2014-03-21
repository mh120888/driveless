module ApplicationHelper
  def flash_class(type)
    case type
    when :alert then 'alert-error'
    when :notice then 'alert-success'
    end
  end
end
