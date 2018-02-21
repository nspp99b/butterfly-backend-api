# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Shahin M", email: "chromepanthers@gmail.com", password: 123456)
User.create(name: "Kerry D", email: "kerry.davis@gmail.com", password: 123456)
User.create(name: "Meg C", email: "claxbo@gmail.com", password: 123456)
User.create(name: "Tat K", email: "tat@gmail.com", password: 123456)

Flap.create(content: "Come check out mondo waves this morning at Beach 90th!", user_id: 1)
Flap.create(content: "Caught crazy waves this morning", user_id: 2)
Flap.create(content: "Hung ten at popping Beach 90th", user_id: 3)
Flap.create(content: "Ruled the lineup today", user_id: 4)

FlapRelationship.create(cause_id: 1, effect_id: 2)
FlapRelationship.create(cause_id: 2, effect_id: 3)
FlapRelationship.create(cause_id: 3, effect_id: 4)
