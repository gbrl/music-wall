# Homepage (Root path)
get '/' do
  erb :index
  redirect '/tracks'
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

post '/tracks' do
  @track = Track.new(
    title:   params[:title],
    url: params[:url],
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