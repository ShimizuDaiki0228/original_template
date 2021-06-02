require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/bottom.rb'
require './models/contribution.rb'
require './models/silhouette.rb'
require './models/user.rb'

before do
    Dotenv.load
    Cloudinary.config do |config|
        config.cloud_name = ENV['CLOUD_NAME']
        config.api_key = ENV['CLOUDINARY_API_KEY']
        config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end
end

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

get '/newbottom' do
    erb :newbottom
end

get '/newtop' do
    erb :newtop
end

get '/newperson' do
    erb :newperson
end
 
get '/create_silhouette' do
    @users = User.all
    @contributions = Contribution.all
    @material_bottoms = MaterialBottom.all
    @material_tops = MaterialTop.all
    @material_persons = MaterialPerson.all
    erb :silhouette
end

get '/confirm' do
    @top = session[:top]
    @bottom = session[:bottom]
    erb :confirm
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

post '/confirm' do
    session[:top] = params[:top]
    session[:bottom] = params[:bottom]
    
    redirect '/confirm'
end







post "/newbottom" do
    img_url = ''
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
    MaterialBottom.create({
        material_bottom_url: img_url
    })
    
    redirect '/newbottom'
end

post "/newtop" do
    img_url = ''
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
    MaterialTop.create({
        material_top_url: img_url
    })
    
    redirect '/newtop'
end

post "/newperson" do
    img_url = ''
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
    MaterialPerson.create({
        material_person_url: img_url
    })
    
    redirect '/newperson'
end