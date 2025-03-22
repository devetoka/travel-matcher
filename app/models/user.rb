class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  has_one_attached :profile_picture

  validates :profile_picture, 
            content_type: { in: ['image/png', 'image/jpeg'], message: 'must be a valid image format' },
            size: { less_than: 5.megabytes, message: 'should be less than 5MB' }
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20}
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :location, length: { maximum: 100 }, allow_blank: true
  validates :phone_number, length: { minimum: 5, maximum: 20 }, allow_blank: true
  validates :preferred_contact_method, inclusion: { in: %w[email phone app] }, allow_blank: true
  validates :bio, length: { maximum: 500 }, allow_blank: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
