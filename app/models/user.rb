class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :token_authenticatable # add this for tiddle

  has_many :authentication_tokens, dependent: :destroy
  has_many :items, dependent: :destroy
end
