module ApplicationHelper
  def controller_action_name
    "#{controller.controller_name} #{controller.action_name}"
  end
end
