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
     binding.pry
      redirect "/products/#{@product.id}"
    else
      redirect '/products/new'
    end
      
  end
  
  get '/products/:id' do
    @product = Product.find(params[:id])
    erb :'/products/show' 
  end
  
  get '/products/:id/edit' do
    @product = Product.find(params[:id])
    erb :'/products/edit'
  end
  
  patch '/products/:id' do
    @product = Product.find_by_id(params[:id])
    @product.update(title: params[:title], price: params[:price], is_listed?: params[:is_listed?], link: params[:link])
    redirect to "/products/#{@product.id}"
  end
  
end