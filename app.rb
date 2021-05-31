require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models.rb'

enable :sessions

get '/' do
    @contents = Contribution.all.order("id desc")
    erb :test
end

get '/signin' do
    erb :sign_in
end

get '/signup' do
    erb :sign_up
end

get '/profile' do
    erb :profile
end

get '/new' do
    erb :new
end

get '/create_silhouette' do
    @users = User.all
    @contributions = Contribution.all
    @material_bottoms = MaterialBottom.all
    erb :silhouette
end

post '/signin' do
    user = User.find_by(mail: params[:mail])
    name = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

post '/signup' do
    @user = User.create(mail:params[:mail], name:params[:name], password:params[:password], introduction:params[:introduction],
    password_confirmation:params[:password_confirmation])
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end


get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/edit/:id' do
    @user = User.find(params[:id])
    erb :edit
end

post '/edit/:id' do
    #@user = User.update(mail: params[:mail], name: params[:name], introduction: params[:introduction])
    user = User.find(params[:id])
    user.update({
    mail: params[:mail],
    name: params[:name],
    introduction: params[:introduction],
  })
    redirect '/'
end

post '/new' do
  Contribution.create({
    body: params[:body],
  })

  redirect "/" 
end

post "/delete/:id" do
  Contribution.find(params[:id]).destroy
  redirect "/"
end