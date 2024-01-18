require "rails_helper"

RSpec.describe "Api::V1::Current::HikingPlans", type: :request do
  
  describe "GET api/v1/current/hiking_plans" do
    subject { get(api_v1_current_hiking_plans_path, headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    before { create_list(:hiking_plan, 2, user: other_user) }

    context "ログインユーザーに紐づく hiking_plans レコードが存在する時" do
      before { create_list(:hiking_plan, 3, user: current_user) }

      it "正常にレコードを取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 3
        expect(res[0].keys).to eq ["id", "mountain_name", "title", "start_date", "end_date", "status", "created_at", "from_today", "user"]
        expect(res[0]["user"].keys).to eq ["id"]
        expect(response).to have_http_status(:ok)
      end
    end

    context "ログインユーザーに紐づく hiking_plans レコードが存在しない時" do
      it "空の配列が返る" do
        subject
        res = JSON.parse(response.body)
        expect(res).to eq []
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET api/v1/current/hiking_plans/:id" do
    subject { get(api_v1_current_hiking_plan_path(id), headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    context ":id がログインユーザーに紐づく hiking_plans レコードの id である時" do
      let(:current_user_hiking_plan) { create(:hiking_plan, user: current_user) }
      let(:id) { current_user_hiking_plan.id }

      it "正常にレコードを取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["id", "mountain_name", "title", "start_date", "end_date", "status", "created_at", "from_today", "user"]
        expect(res["user"].keys).to eq ["id"]
        expect(response).to have_http_status(:ok)
      end
    end

    context ":id がログインユーザーに紐づく hiking_plans レコードの id ではない時" do
      let!(:other_user_hiking_plan) { create(:hiking_plan, user: other_user) }
      let(:id) { other_user_hiking_plan.id }

      it "例外が発生する" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST api/v1/current/hiking_plans" do
    subject { post(api_v1_current_hiking_plans_path, headers:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "ログインユーザーに紐づく未保存ステータスのハイキング計画が0件の時" do
      it "未保存ステータスのハイキング計画が新規作成される" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["id", "mountain_name", "title", "start_date", "end_date", "status", "created_at", "from_today", "user"]
        expect(res["user"].keys).to eq ["id"]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH api/v1/current/hiking_plans" do
    subject { patch(api_v1_current_hiking_plan_path(id), headers:, params:) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:params) {
      { "hiking_plan": { "mountain_name": "新富士山", "title": "新たな挑戦", "start_date": Time.zone.today, "end_date": Time.zone.today + 2, "status": "draft" } }
    }

    context ":id がログインユーザーに紐づく hiking_plans レコードの id である時" do
      let(:current_user_hiking_plan) { create(:hiking_plan, user: current_user) }
      let(:id) { current_user_hiking_plan.id }

      it "正常にレコードを更新できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["user"].keys).to eq ["id"]
        expect(response).to have_http_status(:ok)
      end
    end

    context ":id がログインユーザーに紐づく hiking_plans レコードの id ではない時" do
      let(:other_user_hiking_plan) { create(:hiking_plan, user: create(:user)) }
      let(:id) { other_user_hiking_plan.id }

      it "例外が発生する" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
