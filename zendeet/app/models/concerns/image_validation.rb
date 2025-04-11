# frozen_string_literal: true

module ImageValidation
  extend ActiveSupport::Concern
  ALLOWED_IMAGE_TYPES = %w[image/png image/jpg image/jpeg].freeze
  ALLOWED_IMAGE_SIZE = 5.megabytes
  ALLOWED_NUMBER_OF_IMAGES = 5

  def image_type_valid?(attachment)
    attachment.blank? || ALLOWED_IMAGE_TYPES.include?(attachment.content_type)
  end

  def image_size_valid?(attachment)
    return true if attachment.blank? || attachment.blob.blank?

    attachment.blob.byte_size <= ALLOWED_IMAGE_SIZE
  end

  def validate_image_attachment(record:, attribute:, attachment:)
    unless image_type_valid?(attachment)
      record.errors.add(attribute, "must be a PNG, JPG, or JPEG")
    end

    unless image_size_valid?(attachment)
      record.errors.add(attribute, "must be smaller than #{ALLOWED_IMAGE_SIZE}MB")
    end
  end

  def validate_multiple_attachments(record:, attribute:, attachments:)
    if attachments.size > ALLOWED_NUMBER_OF_IMAGES
      record.errors.add(attribute, "cannot have more than 5 images")
      return
    end

    attachments.each do |attachment|
      validate_image_attachment(record: record, attribute: attribute, attachment: attachment)
    end
  end
end
