class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :post_editings, foreign_key: "post_id"
  has_many :editors, through: :post_editings, source: :editor
  validates :title, presence: true
  validates :content, presence: true
end
