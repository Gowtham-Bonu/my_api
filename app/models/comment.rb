class Comment < ApplicationRecord
  validates :description, :date_of_comment, presence: true

  paginates_per 30
  belongs_to :article
end
