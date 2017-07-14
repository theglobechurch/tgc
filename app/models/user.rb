class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Enable registrations: add :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
