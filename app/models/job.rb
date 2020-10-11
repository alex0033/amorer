class Job < ApplicationRecord
  before_save :align_reward

  belongs_to :user
  has_many :entries, dependent: :destroy
  has_many :entry_users, through: :entries, source: :user

  validates :title,       presence: true, length: { maximum: 30 }
  validates :pay,         length: { maximum: 30 }
  validates :reward_type, presence: true
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

  def align_reward
    if reward_min_amount.present? && reward_max_amount.nil?
      self.reward_max_amount = reward_min_amount
    elsif reward_max_amount.present? && reward_min_amount.nil?
      self.reward_min_amount = reward_max_amount
    end
  end
end
