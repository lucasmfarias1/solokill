class User < ApplicationRecord
  has_many :posts

  mount_uploader :image, ImageUploader
  # validates :image, file_size: { less_than: 1.megabytes }

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def elo
    return 'UNRANKED' unless self.lol_tier

    self.lol_tier + " " + self.lol_rank
  end

  def name
    return self.email unless self.lol_name

    self.lol_name
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.skip_confirmation!
  end
end
end
