# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin',
  password: '111111'
  )

User.create!(
  name: 'たか',
  email: 'ashitaka1259@gmail.com',
  password: '111111'
  )

User.create!(
  name: 'あし',
  email: 'ashitaka1250@gmail.com',
  password: '111111'
  )
  
Category.create!(
  name: '歴史'
  )
  
Category.create!(
  name: '家事'
  )
  
Category.create!(
  name: '動物'
  )
  
Category.create!(
  name: '洗濯'
  )
  
Category.create!(
  name: '料理'
  )
  
Category.create!(
  name: 'DIY'
  )
  
Category.create!(
  name: '釣り'
  )
  
Category.create!(
  name: 'スキー'
  )
  
Category.create!(
  name: 'その他'
  )