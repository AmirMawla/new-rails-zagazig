class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true , format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,message: "must be a valid email address" }
    validates :DOP, presence: true
    validates :phone_number, presence: true
    validates :address, presence: true
end
