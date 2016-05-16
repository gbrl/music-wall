# Homepage (Root path)
get '/' do
  erb :index
  redirect '/tracks'
end

# TRACK ACTIONS

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

post '/tracks' do
  @track = Track.new(
    title:   params[:title],
    url:     params[:url],
    author:  params[:author]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

# USER ACTIONS

get '/users' do
  @users = User.all
  erb :'users/index'
end

post '/users' do
  @user = User.new(
    username:   params[:username],
    email:      params[:email],
    password:   params[:password]
  )
  if @user.save
    redirect '/users'
  else
    erb :'users/new'
  end
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

get '/users/:username' do
  @user = User.find_by_username params[:username]
  erb :'users/show'
end

helpers do
  def cookie_values(parameters)
    values = {}
    parameters.each do |key, value|
      case key
      when 'options'
        values[value] = true
      else
        values[key] = true
      end
    end
    values
  end
end