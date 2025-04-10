class Review < ApplicationRecord
  belongs_to :request
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"

  validates :rating, presence: true, inclusion: { in: 1..5, message: "must be between 1 and 5" }
  validates :comment, length: { maximum: 500, message: "must be 500 characters or less" }, allow_blank: true
  validates :reviewer_id, uniqueness: { scope: :request_id, message: "can only review once per request" }

  scope :excluding_reviewer, ->(user) { where.not(reviewer: user) }

end
