class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id",
  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",
  dependent: :destroy

  has_many :following,through: :active_relationships,source: :followed
  has_many :followers,through: :passive_relationships,source: :follower

  def follow(other)
  	active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
  	active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
  	following.include?(other)
  end

end