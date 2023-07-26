class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :spots, dependent: :destroy

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

end
