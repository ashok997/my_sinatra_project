class ProductsController < ApplicationController
  

  get '/products/new' do 
    erb :'/products/new'
  end
  
  post '/products/new' do
    
    if !logged_in?
      redirect '/'
    end
    if params[:title] != "" && params[:price].to_f !=0 && params[:link] != ""
     @product =Product.create(params)
     @product.user_id = current_user.id
     @product.save
      redirect "/products/#{@product.id}"
    else
      flash[:message] = "All fields are required and price should be a number"
      redirect '/products/new'
    end
      
  end
  
  get '/products/:id' do
    @product = Product.find_by_id(params[:id])
    if @product 
      erb :'/products/show'
    else
      @error = "The product you are looking for does not exit!!"
      erb :'/error'
    end
  end
  
  get '/products/:id/edit' do
    @product = Product.find(params[:id])
  
    if logged_in?
      if @product.user_id ==current_user.id
        erb :'/products/edit'
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect '/'
    end
    
  end
  
  patch '/products/:id' do
    @product = Product.find(params[:id])
    
    if logged_in?
      if @product.user_id ==current_user.id
        @product.update(title: params[:title], price: params[:price], is_listed?: params[:is_listed?], link: params[:link])
        redirect to "/products/#{@product.id}"
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect '/'
    end
  end
  
  delete '/products/:id' do
    @product = Product.find(params[:id])
    @product.destroy
    redirect "users/#{current_user.id}"
  end
  
  get '/products' do
   ## binding.pry
    if params[:search]
      # @products =Product.all.select do |product|
      #   product.title.downcase.include?(params[:search].downcase)
    #  end
      @products = Product.where("title LIKE ?", "%#{params[:search]}%")
    else
     @products =Product.all
    end
    erb :'/products/index'
  end
  

end