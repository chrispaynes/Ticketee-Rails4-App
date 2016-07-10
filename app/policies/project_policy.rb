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

  def show?
    user.try(:admin?) || record.roles.exists?(user_id: user)
  end
end
