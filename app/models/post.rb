class Post < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy

  before_save :set_dates_from_range, if: -> { date_range.present? }
  before_save :prevent_duplicate, if: -> { start_date.present? && end_date.present? }

  validates :post_type,
            presence: true,
            inclusion: { in: %w(sender traveler), message: "%{value} is not a valid type" }
  validates :origin, :destination,
            presence: true,
            length: { minimum: 2, maximum: 20,
                      too_short: "%{count} characters is the minimum allowed",
                      too_long: "%{count} characters is the maximum allowed" }
  validates :description,
            presence: true, length: { maximum: 1000 }, if: -> { post_type == "sender" }
  validates :description,
            length: { maximum: 1000 }, allow_blank: true, if: -> { post_type == "traveler" }
  validates :start_date, :end_date,
            presence: true,  unless: -> { date_range.present?}
  validates :date_range,
            length: { maximum: 50 }, allow_blank: true
  validate :end_date_cannot_be_before_start_date
  validate :date_range_format, if: -> { date_range.present? }

  def formatted_start_date
    start_date.strftime('%B %d, %Y') if start_date.present?
  end

  def formatted_end_date
    end_date.strftime('%B %d, %Y') if end_date.present?
  end

  def self.with_request_count
    left_joins(:requests)
      .select("posts.*, COUNT(requests.id) AS requests_count")
      .group("posts.id")
      .order(created_at: :desc)
  end

  private

  def prevent_duplicate
    if self.class.where(
      user: user,
      origin: origin,
      destination: destination,
      start_date: start_date,
      end_date: end_date,
      post_type: post_type
    ).where.not(id: id).exists? # Exclude itself during update
      errors.add(:base, 'Duplicate record exists')
      throw(:abort) # Prevent saving
    end
  end

  private

  def set_dates_from_range
    prefix, period = date_range.split(/\s+/, 2).map(&:downcase)
    case prefix
    when 'early', 'mid', 'middle', 'late'
      month = Date::MONTHNAMES.index(period.capitalize)
      set_dates(prefix, month) if month
    when 'next'
      set_next_dates(period)
    end
  end

  def end_date_cannot_be_before_start_date
    return if start_date.blank? || end_date.blank?
    if end_date < start_date
      errors.add(:end_date, 'must be after start date')
    end
  end

  def date_range_format
    valid_prefixes = %w(early mid middle late)
    valid_months = Date::MONTHNAMES.compact.map(&:downcase)
    valid_next_period = %w(week month)
    pattern = /\A(#{valid_prefixes.join('|')})\s+(#{valid_months.join('|')})|(next)\s+(#{valid_next_period.join('|')})\z/i

    unless date_range.match?(pattern)
      next_month = Date.today.next_month.strftime("%B")
      errors.add(
        :date_range,
        "must be '(early | mid | middle | late) (full month name)' (e.g., '<strong>Late #{next_month}'</strong>) or '<strong>next week | next month</strong>'")
      return
    end

    set_dates_from_range
    if start_date < Date.today
      errors.add(:date_range, ": '<strong>#{date_range.titlecase}</strong>' is in the past")
    end
  end

  def set_dates(prefix, month)
    current_year = Date.today.year
    case prefix
    when 'early'
      self.start_date = Date.new(current_year, month, 1)
      self.end_date = Date.new(current_year, month, 10)
    when 'mid', 'middle'
      self.start_date = Date.new(current_year, month, 11)
      self.end_date = Date.new(current_year, month, 20)
    when 'late'
      self.start_date = Date.new(current_year, month, 21)
      self.end_date = Date.new(current_year, month, -1)
    end
  end

  def set_next_dates(period)
    case period
    when 'week'
      self.start_date = Date.today.next_week.beginning_of_week
      self.end_date = Date.today.next_week.end_of_week
    when 'month'
      self.start_date = Date.today.next_month.beginning_of_month
      self.end_date = Date.today.next_month.end_of_month
    end
  end
end