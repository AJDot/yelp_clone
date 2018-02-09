class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password
  validates_presence_of :first_name, :last_name, :email, :password
  validates_uniqueness_of :email
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
