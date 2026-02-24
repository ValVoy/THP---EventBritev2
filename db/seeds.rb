Attendance.destroy_all
Event.destroy_all
User.destroy_all

puts "Création de 10 utilisateurs..."
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 10),
    email: Faker::Internet.unique.email,
    password: "password123" # Devise gère le hachage automatiquement
  )
end

puts "Création de 30 événements variés..."
cities = ["Paris", "Lyon", "Bordeaux", "Marseille", "Pau", "Lille", "Nantes"]
users = User.all

30.times do
  Event.create!(
    admin: users.sample,
    title: Faker::Book.title.first(140),
    description: Faker::Lorem.paragraph(sentence_count: 5).first(1000),
    start_date: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 30),
    duration: [ 30, 60, 90, 120, 180 ].sample,
    price: [ 0, 5, 10, 15, 20, 30, 50, 90 ].sample,
    location: cities.sample
  )
end

puts "Base de données prête !"