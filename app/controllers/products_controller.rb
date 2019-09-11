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
    erb :'/products/edit'
  end
  
end