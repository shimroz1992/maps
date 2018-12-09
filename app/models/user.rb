class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :shared_locations, dependent: :destroy
  has_many :locations, dependent: :destroy
  scope :all_except, ->(user) { where.not(id: user) }
  def shared
    locations.joins(:shared_locations).where('shared_locations.user_id = ?', self.id)
  end
  def shared_with
    Location.includes(:shared_locations).where('shared_locations.shared_with_id = ?', self.id).references(:shared_locations)
  end

  def both_locations
    Location.joins(:shared_locations).where('shared_locations.user_id = ? OR shared_locations.shared_with_id = ?',self.id, self.id).references(:shared_locations)
  end

  def public_shared
    Location.joins(:shared_locations).where('shared_locations.user_id = ? and shared_locations.private =?', self.id,false).references(:shared_locations)
  end
end
