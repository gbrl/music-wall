
# USERS

# gabe asdfasdf
# kyle 123456
# jim jimjim
# bob bobbob


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

  @track.user = current_user if current_user

  if @track.save
    session[:new] = false
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end


get '/tracks/new' do
  session[:new] = true
  @track = Track.new
  erb :'tracks/new'
end


get '/track/upvote/:id' do
  if current_user
    track  = Track.find params[:id]
    if track    
      puts "Found a track!"
      upvote = Upvote.where(user_id: current_user.id, track_id: track.id)
      if upvote.length > 0
        puts "Found a pre-existing upvote."
        puts upvote.inspect
      else
        Upvote.register(track.id,current_user.id) 
        puts "No pre-existing upvote found. Registering vote...."
      end
    end
  end
  @tracks = Track.all
  redirect '/tracks'
end


get '/track/downvote/:id' do
  if current_user
    track  = Track.find params[:id]
    if track    
      puts "Found a track!"
      downvote = Downvote.where(user_id: current_user.id, track_id: track.id)
      if downvote.length > 0
        puts "Found a pre-existing downvote."
        puts downvote.inspect
      else
        Downvote.register(track.id,current_user.id)
        puts "No pre-existing downvote found. Registering vote...."
      end
    end
  end
  @tracks = Track.all
  redirect '/tracks'
end


get '/tracks/:id' do
  @track = Track.find params[:id]
  @reviews = @track.reviews
  @review = Review.new
  erb :'tracks/show'
end


# REVIEW ACTIONS

post '/reviews' do
  @review = Review.new(
    rating:   params[:rating],
    content:  params[:content]
  )

  @review.user_id = current_user.id
  @review.track_id = params[:id]
  @review.save
  redirect back 
end


get '/reviews/delete/:id' do
  @review = Review.find params[:id]
  @review.destroy if @review
  redirect back
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
    authenticate
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


get '/users/:username/upvotes' do
  @user = User.find_by_username params[:username]
  @votes = @user.upvotes
  erb :'users/upvotes'
end


get '/users/:username/downvotes' do
  @user = User.find_by_username params[:username]
  @votes = @user.downvotes
  erb :'users/downvotes'
end


# SESSION ACTIONS

post '/authenticate' do
  authenticate
end


get '/login' do
  erb :'login'
end


get '/logout' do
  session.clear
  erb :'logout'
end

helpers do

  def authenticate
    if @user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
      session[:id] = @user.id
      session[:new] = false
      redirect '/tracks'
    else
      @error = 'Wrong email or password.'
      redirect '/login'
    end
  end

  def current_user
    user = false
    if session[:id] and user = User.find(session[:id])
      puts 'User found.'
    end
    user
  end

end