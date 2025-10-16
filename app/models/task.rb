class Task < ApplicationRecord
  belongs_to :campaign, counter_cache: true
  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :assigned_to, class_name: 'User', optional: true

  validates :title, presence: true, length: { maximum: 200 }

  enum status: { todo: 0, in_progress: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
end
