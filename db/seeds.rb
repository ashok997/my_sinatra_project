User.destroy_all
Product.destroy_all

user = User.create(name:"Ashok", email:"ashok@shok.com", password:"ashok000" )

Product.create(title:"toy bus", price:10, is_listed?:false, user_id:user.id, link:"shop.com/shop")
Product.create(title:"toy car", price:15, is_listed?:true, user_id:user.id, link:"shop.com/shop")