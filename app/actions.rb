enable :sessions


# USERS

# gabe asdfasdf
# kyle 123456
# jim jimjim

# HOMEPAGE

get '/' do
  erb :index
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

  if session && session["user"]
   @user = User.find_by_username session["user"]
   @track.user = @user if @user
  end

  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/new' do
  session["action"] = "new"
  @track = Track.new
  erb :'tracks/new'
end

get '/track/upvote/:id' do
  @track = Track.find params[:id]
  if @track
    @track.up_votes += 1 
    @track.save
  end
  @tracks = Track.all
  redirect '/tracks'
end

get '/track/downvote/:id' do
  @track = Track.find params[:id]
  if @track
    @track.down_votes -= 1 
    @track.save
  end
  @tracks = Track.all
  redirect '/tracks'
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

get '/signup' do
  @user = User.new
  erb :'users/new'
end

get '/users/:username' do
  @user = User.find_by_username params[:username]
  erb :'users/show'
end

# SESSION ACTIONS

get '/sessions' do
  @sessions = Session.all
  erb :'sessions'
end


get '/login' do
  @session = Session.new
  erb :'login'
end


get '/logout' do
  @user = User.find_by_username(session["user"])
  @user.session.destroy if @user && @user.session
  session.delete("user")
  erb :'logout'
end


post '/sessions' do
  @user = User.find_by_username(params[:username])

  if @user && @user.password == params[:password]
    session["user"] ||= @user.username
    @session = Session.create(user: @user)
    redirect '/tracks'
  else
    erb :'/login'
  end
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