class PostEditing < ApplicationRecord
  belongs_to :post
  belongs_to :editor, class_name: "User" 
end
