module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do 
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  # determines if current user is an admin
  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end
end