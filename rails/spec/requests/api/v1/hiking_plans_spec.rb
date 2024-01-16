require "rails_helper"

RSpec.describe "Api::V1::HikingPlans", type: :request do
  describe "GET api/v1/hiking_plans" do
    subject { get(api_v1_hiking_plans_path(params)) }

    before do
      user = create(:user)
      create_list(:hiking_plan, 25, status: :published, user:)
      create_list(:hiking_plan, 8, status: :draft, user:)
    end

    context "page を params で送信しない時" do
      let(:params) { nil }

      it "1ページ目のレコード10件取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.keys).to eq ["hiking_plans", "meta"]
        expect(res["hiking_plans"].length).to eq 10
        # 属性は HikingPlan に合わせて調整してください
        expect(res["hiking_plans"][0].keys).to eq ["id", "mountain_name", "title", "start_date", "end_date", "status", "created_at", "from_today", "user"]
        expect(response).to have_http_status(:ok)
      end
    end

    # ... その他のテスト ...
  end

  describe "GET api/v1/hiking_plans/:id" do
    subject { get(api_v1_hiking_plan_path(hiking_plan_id)) }

    let(:hiking_plan) { create(:hiking_plan, status:, user: create(:user)) }

    context "hiking_plan_id に対応する hiking_plan レコードが存在する時" do
      let(:hiking_plan_id) { hiking_plan.id }

      context "hiking_plan レコードのステータスが公開中の時" do
        let(:status) { :published }

        it "正常にレコードを取得できる" do
          subject
          res = JSON.parse(response.body)
          # 属性は HikingPlan に合わせて調整してください
          expect(res.keys).to eq ["id", "mountain_name", "title", "start_date", "end_date", "status", "created_at", "from_today", "user"]
          expect(response).to have_http_status(:ok)
        end
      end

      context "hiking_plan レコードのステータスが下書きの時" do
        let(:status) { :draft }

        it "ActiveRecord::RecordNotFound エラーが返る" do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "hiking_plan_id に対応する hiking_plan レコードが存在しない時" do
      let(:hiking_plan_id) { 10_000_000_000 }

      it "ActiveRecord::RecordNotFound エラーが返る" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
