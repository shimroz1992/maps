module ApplicationHelper
  def users
    User.all_except(current_user).collect {|p| [p.email, p.id ] }
  end
end
