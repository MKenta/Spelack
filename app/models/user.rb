class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # 機能統合した段階で以下の外部キー制約の実装を行う。
  has_many :user_channels
  has_many :channels, through: :user_channels
  has_many :messages
  # has_many :chats
  # has_many :shared_files

  validates :nickname, presence: true, length: { maximum: 20 }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :middle_name, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/default_avatar.png'
  validates_attachment :avatar, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  after_create do
    self.channels << Channel.find(1)
  end
end
