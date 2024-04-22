# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
step_titles = [
  'Welcome to Fabrikator',
  'Set your order lead time',
  'Set days of stock for products',
  'Set forcasting days',
  'Upload existing POs',
  'Match suppliers and products',
  'Set bundles',
  'Set integrations'
]

user = User.create(email: 'oguzbayat77@gmail.com', name: 'Oguz', surname: 'Bayat')
company = Company.create(title: 'test comp',
                         user_id: user.id,
                         status: 'not_start',
                         step_count: step_titles.count,
                         completed_step_count: 0)

step_titles.each_with_index do |title, index|
  company.onboarding_steps.create(
    title: title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    video_info: Faker::Lorem.sentence(word_count: 3),
    step_order: index + 1,
    locked: index > 3
  )
end
