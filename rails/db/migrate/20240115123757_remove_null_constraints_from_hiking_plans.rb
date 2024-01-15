class RemoveNullConstraintsFromHikingPlans < ActiveRecord::Migration[7.0]
  def change
    change_column_null :hiking_plans, :user_id, true
    change_column_null :hiking_plans, :mountain_name, true
    change_column_null :hiking_plans, :title, true
    change_column_null :hiking_plans, :start_date, true
    change_column_null :hiking_plans, :end_date, true
    change_column_null :hiking_plans, :status, true
  end
end
