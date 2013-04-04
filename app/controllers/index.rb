def encrypt_password(password)
  cipher = OpenSSL::Cipher::Cipher.new('bf-cbc').encrypt
  cipher.key = Digest::SHA256.digest('i love dogs')
  cipher.update(password) << cipher.final
end

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/signup' do
  @user = User.new(:first_name => params[:first_name],
                      :last_name => params[:last_name],
                      :email => params[:email],
                      :password => params[:password])
  @user.password
  if @user.save
    login(@user)
    redirect '/shhhhhhhhh'
  else
    erb :index
  end
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    login(@user)
    erb :shhhhhhhhh
  else
    erb :index
  end
end

get '/shhhhhhhhh' do
  if logged_in?
    @user = User.find(session[:token])
    erb :shhhhhhhhh
  else
    redirect '/'
  end
end


get '/logout' do
  session.clear
  redirect '/'
end

