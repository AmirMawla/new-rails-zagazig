class User < ApplicationRecord
    has_many :created_posts, class_name: "Post", foreign_key: "creator_id"
    has_many :post_editings, foreign_key: "editor_id"
    has_many :edited_posts, through: :post_editings, source: :post
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true , format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,message: "must be a valid email address" }
    validates :DOP, presence: true
    validates :phone_number, presence: true
end
