require 'rails_helper'

RSpec.describe Api::V1::VehiclesController do
  let(:vehicle) { create(:vehicle) }
  let(:user) { vehicle.user }

  before do
    request.headers.merge! user.create_new_auth_token
  end

  describe '#index' do
    it 'returns list of vehicles for current user' do

      get :index

      expect(response).to have_http_status(:success)
      assert_json_response([
        {
          "id" => vehicle.id,
          "license_plate" => vehicle.license_plate,
          "car_brand" => vehicle.car_brand,
          "year" => vehicle.year,
          "user_id" => vehicle.user.id
        }
      ], json)
    end
  end

  describe 'POST #create' do
    let(:vehicle_params) {
      attributes_for(:vehicle).merge!(license_plate: 'ZG-123-AB')
    }

    it 'creates vehicle sucessfully' do
      post :create, params: vehicle_params
      expect(json['id']).not_to be_nil
      expect(json['user_id']).to eq(user.id)
    end
  end

  describe 'POST #update' do
    let(:vehicle_params) {
      attributes_for(:vehicle).merge!(id: vehicle.id, license_plate: 'ZG-123-CH')
    }

    it 'updates vehicle sucessfully' do
      put :update, params: vehicle_params
      expect(json['license_plate']).to eq('ZG-123-CH')
    end
  end

  describe 'GET #show' do
    it 'displays a vehicle' do
      get :show, params: { id: vehicle.id }
      expect(json['id']).to eq(vehicle.id)
      expect(json['license_plate']).to eq(vehicle.license_plate)
      expect(json['car_brand']).to eq(vehicle.car_brand)
      expect(json['year']).to eq(vehicle.year)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a vehicle' do
      delete :destroy, params: { id: vehicle.id }
      expect(Vehicle.find_by(id: vehicle.id).present?).to be_falsy
    end
  end

  def assert_json_response(expected_response, json)
    jsonized_expected = JSON.load(JSON.dump(expected_response))
    expect(json).to eq(jsonized_expected)
  end
end
