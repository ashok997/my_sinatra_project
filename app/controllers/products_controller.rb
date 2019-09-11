class ProductsController < ApplicationController

  get '/products/new' do 
    erb :'/products/new'
  end
  
  post '/products/new' do
    if !logged_in?
      redirect '/'
    end
    
    if params[:title] != ""
      @product =Product.create()
      redirect "/products/#{@product.id}"
    else
      redirect '/products/new'
    end
      
  end
  
end