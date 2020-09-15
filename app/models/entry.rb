class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :user, uniqueness: { scope: :job }
end
