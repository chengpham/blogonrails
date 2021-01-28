# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.delete_all


    70.times do
        p=Post.create(
            title: Faker::Quote.famous_last_words,
            body: Faker::Lorem.sentence(word_count: 100)
        )
        if p.valid?
            p.comments = rand(2..25).times.map do
                Comment.create(
                  body: Faker::Hipster.paragraph
                )
            end
        end
    end
    70.times do
        p=Post.create(
            title: Faker::Quote.yoda,
            body: Faker::Lorem.sentence(word_count: 100)
        )
        if p.valid?
            p.comments = rand(2..25).times.map do
                Comment.create(
                  body: Faker::Hipster.paragraph
                )
            end
        end
    end


puts "Post Count #{Post.count}"