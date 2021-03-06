# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  validates :body, presence: true, length: { maximum: 1000 }
  validates :images, presence: true

  scope :body_contain, ->(body) { where('body LIKE ?', "%#{body}%") }
  scope :comment_contain, ->(comment_body) { joins(:comments).where('comments.body LIKE ?', "%#{comment_body}%") }
  scope :username_contain, ->(username) { joins(:user).where('username LIKE ?', "%#{username}%") }
end
