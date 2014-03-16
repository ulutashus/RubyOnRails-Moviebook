class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_salt, :password_hash 
  
  validates_presence_of :password, :on => :create
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  before_save :encrypt_password
  
  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
