class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: ["Fiction", "Non-Fiction"]

  validate :title_does_not_include?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i,
  ]

  def title_does_not_include?
    if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match title }
      errors.add(:title, "must be clickbait")
    end
  end
end
