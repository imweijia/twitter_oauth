get '/' do
  if session[:username]
    @user = User.find_by_nickname(session[:username])
  end
  erb :index
end
