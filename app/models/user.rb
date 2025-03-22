class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :confirmable

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
    # puts "here , here" + profile_picture.methods.join(" ").to_s
    profile_picture.present? && profile_picture.name.present?
  end


  def correct_profile_picture_format
    return if profile_picture.blank?  # Allow blank values
    allowed_types = ["image/png", "image/jpg", "image/jpeg"]

    unless allowed_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a PNG, JPG, or JPEG")
    end
  end
end
