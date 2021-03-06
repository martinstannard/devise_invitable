class User < ActiveRecord::Base
  devise :authenticatable, :confirmable, :recoverable, :rememberable, :validatable
  attr_accessible :username, :email, :password, :password_confirmation
end
