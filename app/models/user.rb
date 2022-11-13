class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :posts

  def jwt_payload
    super
  end

  def generate_jwt
    Warden::JWTAuth::UserEncoder.new.call(User.first, :user, nil).first
  end
end
