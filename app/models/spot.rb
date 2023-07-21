class Spot < ApplicationRecord
  belongs_to :member
  belongs_to :tag

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

  def current_position
    #現在地を返す
  end

  def address
    [street, city, state, country].compact.join(', ')
  end

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode
end
