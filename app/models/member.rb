class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :spots, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  #フォロー機能
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  GUEST_MEMBER_NAME = 'GuestMember'
  GUEST_MEMBER_EMAIL =  'guest@fukuoka.com'

  # Add guest log_in action
  def self.guest
    find_or_create_by!(name: GUEST_MEMBER_NAME, email: GUEST_MEMBER_EMAIL) do |member|    #データの検索と作成を自動的に判断して処理を行う
      member.password = SecureRandom.urlsafe_base64
    end
  end

  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user_id)
    followings.include?(user_id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @member = Member.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @member = Member.where("name LIKE?","%#{word}%")
    else
      @member = Member.all
    end
  end
end
