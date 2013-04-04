helpers do

  def login(user)
    session[:token] = user.id
  end

  def logged_in?
    session[:token]
  end

end