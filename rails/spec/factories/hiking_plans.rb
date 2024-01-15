FactoryBot.define do
  factory :hiking_plan do
    user
    mountain_name { "MyString" }
    title { "MyString" }
    start_date { "2024-01-15" }
    end_date { "2024-01-15" }
    status { :published }
  end
end
