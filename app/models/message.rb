class Message < ActiveRecord::Base
  belongs_to :user
  validates :text, presence: true, length: { maximum: 4000 }
  attr_writer :nickname

  def nickname
    @nickname || self.user.nickname if self.user.present?
  end
end
