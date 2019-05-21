class User < ApplicationRecord
  # acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,  :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist
  end
