class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :post_user_id, foreign_key: true, :limit => 8 
      t.integer :match_id, foreign_key: true
      t.integer :like_user_id, foreign_key: true, :limit => 8 

      t.timestamps
    end
  end
end
