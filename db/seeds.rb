
Post.delete_all
Comment.delete_all
User.delete_all


PASSWORD='supersecret'

super_user=User.create(
    name: 'Jon Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    admin: true
)

20.times do
    name = Faker::Name.name
    User.create(
        name: name,
        email: "#{name.split.map(&:capitalize).join('.')}@example.com",
        password: PASSWORD,
        created_at: Faker::Date.backward(days: 365)
    )
end
users=User.all
70.times do
    p=Post.create(
        title: Faker::Quote.famous_last_words,
        body: Faker::Lorem.sentence(word_count: 100),
        user: users.sample
    )
    if p.valid?
        p.comments = rand(2..25).times.map do
            Comment.create(
                body: Faker::Hipster.paragraph,
                user: users.sample
            )
        end
    end
end
70.times do
    p=Post.create(
        title: Faker::Quote.yoda,
        body: Faker::Lorem.sentence(word_count: 100),
        user: users.sample
    )
    if p.valid?
        p.comments = rand(2..25).times.map do
            Comment.create(
                body: Faker::Hipster.paragraph,
                user: users.sample
            )
        end
    end
end

puts "Post Count #{Post.count}"
puts "Comment Count #{Comment.count}"
puts "User Count #{User.count}"