# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:vehicle) do
    create(:vehicle)
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    subject { build(:vehicle) }
    it { should validate_presence_of(:license_plate) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:car_brand) }
    it { should validate_uniqueness_of(:license_plate).scoped_to(:user_id) }
  end

  specify 'factory' do
    expect(vehicle.valid?).to be_truthy
  end
end
