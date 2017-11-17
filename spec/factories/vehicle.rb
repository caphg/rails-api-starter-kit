# frozen_string_literal: true
FactoryGirl.define do
  factory :vehicle, class: Vehicle do
    association :user, factory: :user

    license_plate Faker::Vehicle.vin
    car_brand Faker::Vehicle.manufacture
    year { 2011 }
  end
end
