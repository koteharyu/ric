# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  notifiable_type :string(255)
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_notifications_on_notifiable_type_and_notifiable_id  (notifiable_type,notifiable_id)
#  index_notifications_on_user_id                            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord

  include Rails.application.routes.url_helpers

  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  enum read: { unread: false, read: true }

  scope :recent, -> (count) { order(created_at: :desc).limit(count)}

  def call_appropriate_partial
    case self.notifiable_type
    when 'Comment'
      'commented_to_own_post'
    when 'Like'
      'liked_to_own_post'
    when 'Relationship'
      'followed_me'
    end
  end

  def appropriate_path
    case self.notifiable_type
    when 'Comment'
      post_path(self.notifiable.post, anchor: "Comment-#{notifiable.id}")
    when 'Like'
      post_path(self.notifiable.post)
    when 'Relationship'
      user_path(self.notifiable.follower)
    end
  end
end
