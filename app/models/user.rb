class User < ApplicationRecord
  has_many :jobs,    dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :receiving_messages, class_name: "Message",
                                foreign_key: "receiver_id"
  has_many :sending_messages,   class_name: "Message",
                                foreign_key: "sender_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :self_introduction,    length: { maximum: 2000 }
end
