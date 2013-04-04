class User < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :password, :format => { :with => /[\w]{6,}/,
            :message => "must be at least 6 characters."}


  # e.g., User.authenticate('jesse@devbootcamp.com', 'apples123')
  
  include BCrypt

  def self.authenticate(email, password)
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
    @user = User.find_by_email_and_password(email, password)
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end