class CreateHikingPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :hiking_plans do |t|
      # Deviseユーザーへの参照（外部キー）
      t.references :user, null: false, foreign_key: true

      # 登山する山の名前
      t.string :mountain_name, null: false

      # 登山計画のタイトルやスローガン
      t.string :title, null: false

      # 登山の開始日
      t.date :start_date, null: false

      # 登山の終了日
      t.date :end_date, null: false

      # 登山計画のステータス（10:未保存, 20:下書き, 30:公開中）
      t.integer :status, comment: "ステータス（10:未保存, 20:下書き, 30:公開中）"

      # レコード作成日時と更新日時
      t.timestamps
    end
  end
end
