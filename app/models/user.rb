class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :confirmable

  has_many :posts
  has_many :requests, foreign_key: "requester_id", dependent: :destroy
  has_many :received_requests, through: :posts, source: :requests
  has_one_attached :profile_picture

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20}
  validates :first_name, :last_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :location, length: { minimum: 3, maximum: 100 }, allow_blank: true
  validates :phone_number, length: { minimum: 5, maximum: 20 }, allow_blank: true
  validates :preferred_contact_method, inclusion: { in: %w[email phone app] }, allow_blank: true
  validates :bio, length: { maximum: 300 }, allow_blank: true
  validate :correct_profile_picture_format

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile_picture_exists?
    profile_picture.present? && profile_picture.name.present?
  end

  def all_requests
    Request
      .where(requester_id: id)
      .or(Request.where(post_id: posts.select(:id)))
      .includes(:requester, post: :user)
  end


  def correct_profile_picture_format
    return if profile_picture.blank?  # Allow blank values
    allowed_types = ["image/png", "image/jpg", "image/jpeg"]

    unless allowed_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a PNG, JPG, or JPEG")
    end
  end
end
