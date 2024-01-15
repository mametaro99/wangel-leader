require 'rails_helper'

RSpec.describe HikingPlan, type: :model do
  context "factoryのデフォルト設定に従った時" do
    subject { create(:hiking_plan) }

    it "正常にレコードを新規作成できる" do
      expect { subject }.to change { HikingPlan.count }.by(1)
    end
  end

  describe "Validations" do
    subject { hiking_plan.valid? }

    let(:hiking_plan) { build(:hiking_plan, mountain_name:, title:, start_date:, end_date:, status:, user:) }
    let(:mountain_name) { "富士山" }
    let(:title) { "富士山に行って、日本一を眺めよう！" }
    let(:start_date) { Time.zone.today }
    let(:end_date) { Time.zone.today + 2.days }
    let(:status) { :published }
    let(:user) { create(:user) }

    context "全ての値が正常な時" do
      it "検証が通る" do
        expect(subject).to be_truthy
      end
    end

    context "タイトルが空の時" do
      let(:title) { "" }

      it "エラーメッセージが返る" do
        expect(subject).to be_falsy
        expect(hiking_plan.errors.full_messages).to include("タイトルを入力してください")
      end
    end

    # 他に必要なバリデーションテストをここに追加
  end
end
