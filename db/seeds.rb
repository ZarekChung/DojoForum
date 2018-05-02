Category.destroy_all

category_list = [
  { name: "商業類"},
  { name: "技術類"},
  { name: "心理類"}
]

category_list.each do |category|
  Category.create( name: category[:name])
end

puts "Category created!"


Privacy.destroy_all

privacy_list = [
  { name: "ALL"},
  { name: "Friend"},
  { name: "Myself"}
]

privacy_list.each do |privacy|
  Privacy.create( name: privacy[:name])
end

puts "Privacy created!"
