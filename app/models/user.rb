class User < ActiveRecord::Base
  has_many :roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  scope :excluding_archived, lambda { where(archived_at: nil) }

  # adds archived_at property to user
  def archive
    self.update(archived_at: Time.now)
  end

  # determines if a user account is unlocked
  def active_for_authentication?
    super && archived_at.nil?
  end

  # defines inactive status based on a user account status
  def inactive_message
    archived_at.nil? ? super : :archived
  end

  # retrieves a users role on a project
  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end
end
