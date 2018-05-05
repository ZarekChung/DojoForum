namespace :dev do

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
