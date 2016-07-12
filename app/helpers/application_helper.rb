module ApplicationHelper

  # defines a list of roles and creates titleized version for dropdown menu
  def roles
    hash = {}
    
    Role.available_roles.each do |role|
      hash[role.titleize] = role
    end

    hash
  end

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
