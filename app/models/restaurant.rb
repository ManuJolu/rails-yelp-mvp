class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true

  CATEGORY = ["chinese", "italian", "japanese", "french", "belgian"]
  validates :category, inclusion: { in: CATEGORY, allow_nil: false }

  def avg_stars
    ratings = reviews.map { |review| review.rating }
    ratings.size > 0 ? avg = ratings.sum.fdiv(ratings.size).round : avg = 0
    (('<i class="fa fa-star"></i>' * avg) + ('<i class="fa fa-star-o"></i>' * (5 - avg))).html_safe
  end
end
