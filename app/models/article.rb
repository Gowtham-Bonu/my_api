class Article < ApplicationRecord
  validates :title, :release_date, presence: true

  has_many :comments, dependent: :destroy
  
  paginates_per 8
end
