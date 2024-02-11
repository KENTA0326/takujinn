module ApplicationHelper

  def admin_url?
    request.fullpath.include?("/admin")
  end

end
