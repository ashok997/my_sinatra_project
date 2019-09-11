class ProductsController < ApplicationController

  get '/products/new' do 
    erb :'/products/new'
  end
  
  post '/products/new' do
    
    if !logged_in?
      redirect '/'
    end
    
    if params[:title] != ""
     @product =Product.create(params)
     @product.user_id = current_user.id
     @product.save
     binding.pry
      redirect "/products/#{@product.id}"
    else
      redirect '/products/new'
    end
      
  end
  
  get '/products/:id' do
    @product = Product.find(params[:id])
    binding.pry
    erb :'/products/show' 
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
    @product.update(title: params[:title], price: params[:price], is_listed?: params[:is_listed?], link: params[:link])
    redirect to "/products/#{@product.id}"
  end
  
end