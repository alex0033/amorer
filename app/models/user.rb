class User < ApplicationRecord
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

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  validates :name, presence: true, length: { maximum: 20 }
  validates :self_introduction,    length: { maximum: 2000 }

  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                    size: { less_than: 5.megabytes, message: 'のデータサイズが大きすぎます' }

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
