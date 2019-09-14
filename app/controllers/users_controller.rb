class UsersController < ApplicationController
  
  get '/login' do 
    erb :login
  end
  
  post '/login' do 
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "users/#{@user.id}"
    else
      flash[:message] = "Your credentials were wrong. Please try again or Sign Up."
      redirect '/login'
    end
  end
  
  get '/signup' do
    erb :signup
  end
  
  post '/users' do
    if params[:name] !="" && params[:email] !="" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/signup'
    end
  end
  
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    if @user
      @myproducts = @user.products
      erb :'/users/show'
      
    else
      @error = "The user you are looking for does not exist!"
      erb :'/error'
    end
  end
  
  get '/logout' do
    session.clear
    redirect '/'
  end
  
end