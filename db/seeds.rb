# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "fukuoka@gmail.com",
  password: "fukuoka"
)

Member.create!(
  [
  { name: "博多", email: "hakata@fukuoka", password: "hakata"},
  { name: "西鉄", email: "nishitetu@fukuoka", password: "nishitetu"},
  { name: "太宰府", email: "dazaifu@fukuoka", password: "dazaifu"},
  { name: "大名", email: "daimyo@fukuoka", password: "daimyo"},
  { name: "西新", email: "nishijin@fukuoka", password: "nishijin"}
  ]
  )

Tag.create!(
  [
  { name: "Food" },
  { name: "観光名所" },
  { name: "公園" }
  ]
  )