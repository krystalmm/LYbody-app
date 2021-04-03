module ApplicationHelper
  def flash_class(type)
    case type
    when 'success', 'notice' then 'ui success message'
    when 'danger', 'alert' then 'ui error message'
    end
  end
end
