class Job < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title,       presence: true, length: { maximum: 30 }
  validates :pay,         presence: true, length: { maximum: 30 }
  validates :explanation, presence: true, length: { maximum: 2000 }

  def self.search(search)
    Job.where("title LIKE ?", "%#{search}%").
      or(where("pay LIKE ?", "%#{search}%")).
      or(where("explanation LIKE ?", "%#{search}%")).
      order(created_at: :desc)
  end

  def is_entered_by(user)
    Entry.find_by(user: user, job: self)
  end
end
