class Comment < ApplicationRecord
  validates :description, :date_of_comment, presence: true

  belongs_to :article

  paginates_per 30
end
