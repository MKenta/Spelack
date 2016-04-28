class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  soft_deletable column: :delete_at
  validates :name, presence: true, format: { with: /\A[a-z0-9_\-]+\z/ }, length: { maximum: 50 }, uniqueness: true
  validates :status, presence: true
  validates :description, length: { maximum: 255 }
  validates :author_id, presence: true

  def self.search(query)
    if query
      Channel.where(['name LIKE ? ', "%#{query}%"]).without_soft_destroyed
    else
      Channel.without_soft_destroyed
    end
  end
end
