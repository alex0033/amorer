class Message < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :sender,   class_name: "User"

  validates :title,       presence: true, length: { maximum: 30 }
  validates :receiver_id, presence: true
  validates :sender_id,   presence: true
  validates :read,        inclusion: { in: [true, false] }
  validates :kind,        presence: true
  validates :content,     presence: true, length: { maximum: 2000 }
end
