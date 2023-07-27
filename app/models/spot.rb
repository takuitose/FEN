class Spot < ApplicationRecord
  belongs_to :member
  belongs_to :tag
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  def get_image(*size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end

    if !size.empty?
      image.variant(resize: size)
    else
      image
    end
  end

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end


  def current_position
    #現在地を返す
  end

  def address
    [street, self[:city], self[:state]].compact.join(', ')
  end

  def street
    self[:address].present? ? self[:address].split(',').first : nil
  end


  geocoded_by :address, latitude: :latitude, longitude: :longitude
  after_validation :geocode
end
