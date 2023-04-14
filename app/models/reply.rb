class Reply < ApplicationRecord
  belongs_to :discussion
  belongs_to :user
  belongs_to :parent, class_name: 'Reply', optional: true
  has_many :replies, foreign_key: :parent_id 
  validates :reply, presence: true
  has_many :likes, as: :likeable

  extend FriendlyId
  friendly_id :reply, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    reply_changed?
  end

end
