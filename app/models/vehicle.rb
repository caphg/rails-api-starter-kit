class Vehicle < ActiveRecord::Base
  belongs_to :user

  validates :user_id,
            :license_plate,
            :car_brand,
            presence: true

  validates :license_plate, uniqueness: { scope: :user_id }

  scope :for_user, ->(user) { where(user_id: user.id) }
end
