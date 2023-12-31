class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  

  private
    # Проводит валидацию размера загруженного изображения.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "должно быть меньше, чем 5MB")
    end
  end

    

end
