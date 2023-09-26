class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  validates :name, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }



# Возвращает ленту сообщений пользователя.
def feed
 following_ids = "SELECT followed_id FROM relationships
                WHERE  follower_id = :user_id"
Post.where("user_id IN (#{following_ids})
                OR user_id = :user_id", user_id: id)
end

# подписаться на пользователя.
def follow(other_user)
  active_relationships.create(followed_id: other_user.id)
end

# отписаться от пользователя.
def unfollow(other_user)
  active_relationships.find_by(followed_id: other_user.id).destroy
end

# Возвращает true, если текущий пользователь подписан на другого пользователя.
def following?(other_user)
 following.include?(other_user)
end

end
