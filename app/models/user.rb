# app/models/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # Nếu provider (Google) trả về email, thì dùng email đó
      if auth.info.email
        user.email = auth.info.email
      else
        # Nếu provider (LINE) không trả về email, thì tạo email giả
        user.email = "#{auth.uid}@line.placeholder.com" # Thêm .com cho giống email thật
      end

      user.password = Devise.friendly_token[0, 20]

      # user.name = auth.info.name   # assuming your user model has a name
      # user.image = auth.info.image # assuming your user model has an image
    end # Đây là end cho khối 'do |user|'
  end # Đây là end cho 'def self.from_omniauth'
end # Đây là end cho 'class User'
