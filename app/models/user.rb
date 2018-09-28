class User < ApplicationRecord
  has_many :posts
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def elo
    return 'UNRANKED' unless self.lol_tier

    self.lol_tier + " " + self.lol_rank
  end

  def name
    return self.email unless self.lol_name

    self.lol_name
  end
end
