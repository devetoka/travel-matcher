class Request < ApplicationRecord
  include ImageValidation
  belongs_to :post
  belongs_to :requester, class_name: "User"
  has_many :reviews, dependent: :destroy

  has_many_attached :images


  validates :status, inclusion: { in: %w[pending accepted rejected] }
  validates :description, presence: true, if: -> { post.post_type == "traveler" } # Required for sender requests
  validate :requester_not_post_owner
  validate :sender_cannot_accept_request
  validate :prevent_duplicate_request
  validate :check_images

  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected" }
  enum milestone: { pending_handover: "pending_handover", handed_over: "handed_over", delivered: "delivered" }

  scope :for_user, ->(user) { where(requester: user).or(where(post: user.posts)) }

  def contact_info_available?
    accepted?
  end

  def reviewable?
    accepted?
  end

  def requested_by_sender?
    post.post_type == "traveler"
  end

  def get_contact(current_user)
    return nil unless current_user || accepted?

    requester == current_user ? post.user : requester
  end

  def can_accept_request?(user)
    post.post_type == "traveler" && pending? && user == post.user
  end

  private

  def check_images
    validate_multiple_attachments(record: self, attribute: :images, attachments: images)
  end

  def prevent_duplicate_request
    errors.add(:base, 'You already requested/accepted this post') unless Request.where(post: post, requester: requester).where.not(id: id).blank?
  end

  private

  def sender_cannot_accept_request
    errors.add(:base, "You are unauthorized to accept.") if post.post_type == "traveler" && accepted?
  end

  private

  def requester_not_post_owner
    errors.add(:base, "You cannot request your own post.") if requester == post.user
  end
end