class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :spots, dependent: :destroy



  # Add guest log_in action
  def self.guset
    find_or_create_by!(email: 'guest@example.com') do |member|    #データの検索と作成を自動的に判断して処理を行う
      member.password = SecureRandom.urlsafe_base64
      member.name = 'ゲスト'
    end
    sign_in member
    redirect_to about_path, notice: "ゲストメンバーとしてログインしました。"
  end

end
