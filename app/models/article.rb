class Article < ApplicationRecord
  paginates_per 8
  has_many :comments, dependent: :destroy

  validates :title, :release_date, presence: true
end
