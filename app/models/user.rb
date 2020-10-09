class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  has_many :jobs,    dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :receiving_messages,
           -> { order(created_at: :desc) },
           class_name: "Message",
           foreign_key: "receiver_id"

  has_many :sending_messages,
           -> { order(created_at: :desc) },
           class_name: "Message",
           foreign_key: "sender_id"

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 20 }
  validates :self_introduction,    length: { maximum: 2000 }

  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                    size: { less_than: 5.megabytes, message: 'のデータサイズが大きすぎます' }

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
          name: data['name'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  with_options presence: true, if: :was_attached? do
    validates :x
    validates :y
    validates :height
    validates :width
  end

  def count_not_read_messages
    Message.where(receiver: self).where(read: false).size
  end

  def show_image
    image.variant(crop: "#{width}x#{height}+#{x}+#{y}")
  end

  def was_attached?
    image.attached?
  end
end
