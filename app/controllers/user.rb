set :protection, except: :session_hijacking

get '/login' do
  session[:username] = true
  redirect to ("/auth/twitter")
end

get '/logout' do
  session[:username] = nil
  "Logged out"
  redirect to ('/')
end

get '/auth/twitter/callback' do #callback route handler

  env['omniauth.auth'] ? session[:username] = true : halt(401,'Not Authorized')
  "You are now logged in"

  @user = User.find_or_create(env['omniauth.auth'])
  session[:username] = @user.nickname
  redirect '/'
end

get '/auth/failure' do
  params[:message]
end

post '/tweet' do
  puts "This is session username"
  puts session[:username]
  User.find_by_nickname(session[:username]).post_tweet(params[:tweet])
  erb :index
end

