namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    20.times do |i|
      name = FFaker::Name::first_name_female
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "user#{i}@example.co",
        password: "1qaz2wsx",
        intro: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
    end

    puts User.count
  end


  task fake_post: :environment do
    Post.destroy_all
    200.times do |i|
      post = Post.create!(
        title: FFaker::Product.product_name,
        article: FFaker::Lorem.paragraph,
        privacy: Privacy.all.sample,
        replies_count: rand(10..200),
        view_count: rand(10..200),
        user_id: 1,
        is_draft: true,
        photo: FFaker::PhoneNumber.short_phone_number,
        updated_at: FFaker::Time.datetime
      )
    end
      puts "fake_post done"
  end

  task fake_category_of_post: :environment do
    CategoryOfPost.destroy_all
    200.times do |i|
      categoryOfPost = CategoryOfPost.create!(
       post: Post.all.sample,
       category: Category.all.sample
      )
    end
      puts "fake_fake_category_of_post done"
  end

end
