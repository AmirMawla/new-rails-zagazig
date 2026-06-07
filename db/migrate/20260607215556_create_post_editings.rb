class CreatePostEditings < ActiveRecord::Migration[8.1]
  def change
    create_table :post_editings do |t|
      t.references :post, null: false, foreign_key: true
      t.references :editor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
