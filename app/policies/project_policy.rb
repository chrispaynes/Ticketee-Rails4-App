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

  # authorizes admins and signed in users to view a project
  def show?
    user.try(:admin?) || record.roles.exists?(user_id: user)
  end

  # authorizes admins and managers to update a project
  def update?
    user.try(:admin?) || record.roles.exists?(user_id: user, role: "manager")
  end
end
