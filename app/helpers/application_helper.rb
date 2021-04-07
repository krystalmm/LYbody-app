module ApplicationHelper
  def flash_class(type)
    case type
    when 'success', 'notice' then 'alert-success'
    when 'danger', 'alert' then 'alert-danger'
    when 'info' then 'alert-info'
    end
  end
end
