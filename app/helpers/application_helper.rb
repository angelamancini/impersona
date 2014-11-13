module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def active_nav(actionName)
    'active' if params[:action] == actionName
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when :success
      'alert-success'
    when :error
      'alert-danger'
    when :alert
      'alert-block'
    when :notice
      'alert-info'
    else
      flash_type.to_s
    end
  end
end
