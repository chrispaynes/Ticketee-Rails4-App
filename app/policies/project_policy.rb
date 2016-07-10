class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # defines the project scope depending on a user's role.
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      # uses SQL INNER JOIN to return all projects for signed in users
      scope.joins(:roles).where(roles: {user_id: user})
    end
  end

  # authorizes admins and specific user roles to perform controller actions 
  
  def show?
    user.try(:admin?) || record.has_member?(user) 
  end

  def update?
    user.try(:admin?) || record.has_manager?(user) 
  end
end
