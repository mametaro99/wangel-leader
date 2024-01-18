class Api::V1::Current::HikingPlansController < Api::V1::BaseController
  before_action :authenticate_user!

  def index
    hiking_plans = current_user.hiking_plans.not_unsaved.order(created_at: :desc)
    render json: hiking_plans
  end

  def show
    hiking_plan = current_user.hiking_plans.find(params[:id])
    render json: hiking_plan
  end

  def create
    unsaved_hiking_plan = current_user.hiking_plans.unsaved.first || current_user.hiking_plans.create!(status: :unsaved)
    render json: unsaved_hiking_plan
  end

  def update
    hiking_plan = current_user.hiking_plans.find(params[:id])
    hiking_plan.update!(hiking_plan_params)
    render json: hiking_plan
  end

  private

    def hiking_plan_params
      params.require(:hiking_plan).permit(:mountain_name, :title, :start_date, :end_date, :status)
    end
end
