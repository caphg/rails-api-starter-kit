# frozen_string_literal: true

module Api::V1
  class VehiclesController < ApplicationController
    before_action :authenticate_user!

    def index
      vehicles = Vehicle.for_user(current_user)
      render json: vehicles
    end

    def create
      vehicle = current_user.vehicles.build(vehicle_params)
      vehicle.save!
      render json: vehicle
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    def show
      render json: vehicle
    end

    def update
      vehicle.update!(vehicle_params)
      render json: vehicle.reload
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    def destroy
      vehicle.destroy!
      head(204)
    end

    private

    def vehicle
      @vehicle ||= current_user.vehicles.find_by(id: params[:id])
    end

    def vehicle_params
      params.permit(:id, :license_plate, :car_brand, :year)
    end
  end
end
