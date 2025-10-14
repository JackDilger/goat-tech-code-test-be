class Campaign < ApplicationRecord
  # BUG 1:
  validates :name, presence: true, length: { maximum: 100 }

  # BUG 2:
  has_one :tasks

  # BUG 3:
  enum status: [:active, :completed, :archived]
end