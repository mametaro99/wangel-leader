class Api::V1::HikingPlansController < ApplicationController
  include Pagination
  def index
    hiking_plans = HikingPlan.published.order(created_at: :desc).page(params[:page] || 1).per(10).includes([:user])
    render json: hiking_plans, meta: pagination(hiking_plans), adapter: :json
  end

  def show
    hiking_plan = HikingPlan.published.find(params[:id])
    render json: hiking_plan
  end
end
