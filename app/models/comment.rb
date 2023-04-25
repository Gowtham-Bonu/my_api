class Comment < ApplicationRecord
  paginates_per 30
  belongs_to :article

  validates :description, :date_of_comment, presence: true
end
