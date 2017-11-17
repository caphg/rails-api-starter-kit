class Vehicle < ActiveRecord::Base
  belongs_to :user

  validates :user_id,
            :license_plate,
            :car_brand,
            presence: true

  validates :license_plate, uniqueness: { scope: :user_id }
end
