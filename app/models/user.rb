class User < ApplicationRecord
  has_many :posts
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def elo
    return 'Unranked' unless self.lol_tier
    return 'w000ps'
  end
end
