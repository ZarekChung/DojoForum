namespace :dev do
  task fake_user: :environment do
    #User.destroy_all

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
      #count = rand(1..20)
      file = File.open("#{Rails.root}/public/photo/pic.jpg")
      post = Post.create!(
        title: FFaker::Product.product_name,
        article: FFaker::Lorem.paragraph,
        privacy: Privacy.all.sample,
        replies_count: rand(10..200),
        view_count: rand(10..200),
        user: User.all.sample,
        is_draft: true,
        photo: file,
        updated_at: FFaker::Time.datetime
      )
    end
      puts "fake_post done"
  end

  task fake_category_of_post: :environment do
    CategoryOfPost.destroy_all
    Post.all.each do |post|
      Category.all.each do |c|
        categoryOfPost = CategoryOfPost.create!(
         post: post,
         category: c,
         is_checked: true
        )
      end
    end
      puts "fake_fake_category_of_post done"
  end

  task fake_firend: :environment do
    Friendship.destroy_all
    User.all.each do |user|
      5.times do |i|
        friendship = Friendship.create!(
          user: user,
          friend: User.all.sample,
        )
      end
    end
    puts "fake_fake_category_of_post done"
  end

  task fake_replies: :environment do
    Reply.destroy_all
    Post.all.each do |tweet|
     3.times do |i|
     Reply.create!(
       content: FFaker::Lorem.sentence[0..140],
       user: User.all.sample,
       post: Post.all.sample
     )
     end
   end
   User.all.each do |user|
     user.update_attributes(replies_count: user.replies.count)
   end
   Post.all.each do |post|
     post.update_attributes(replies_count: post.replies.count)
   end
      puts "fake_replies done"
  end

end
