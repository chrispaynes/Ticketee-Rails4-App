class State < ActiveRecord::Base
  def self.default
    find_by(default: true)
  end

  def to_s
    name
  end
end
