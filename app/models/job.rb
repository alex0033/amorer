class Job < ApplicationRecord
  belongs_to :user

  validates :title,       presence: true, length: { maximum: 30 }
  validates :pay,         presence: true, length: { maximum: 30 }
  validates :explanation, presence: true, length: { maximum: 2000 }
end
