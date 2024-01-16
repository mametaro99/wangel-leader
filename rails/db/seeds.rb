ActiveRecord::Base.transaction do
  user1 = User.create!(name: "山岳太郎", email: "yama1@example.com", password: "password", confirmed_at: Time.current)
  user2 = User.create!(name: "山岳次郎", email: "yama2@example.com", password: "password", confirmed_at: Time.current)

  5.times do |i|
    HikingPlan.create!(
      mountain_name: "富士山",
      title: "富士山登山計画#{i}",
      start_date: Time.zone.today + i.days,
      end_date: Time.zone.today + (i + 2).days,
      status: :published,
      user: user1,
    )
  end

  5.times do |i|
    HikingPlan.create!(
      mountain_name: "北アルプス",
      title: "北アルプス登山計画#{i}",
      start_date: Time.zone.today + i.days,
      end_date: Time.zone.today + (i + 3).days,
      status: :draft,
      user: user2,
    )
  end
end
