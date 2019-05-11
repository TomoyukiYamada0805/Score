class CreateEvaluatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluate_players do |t|

      t.integer :user_id, :null => false, :limit => 8 
      t.integer :player_id
      t.float :evaluate_point
      t.text  :evaluate_comment
      t.integer :del_flg

      t.timestamps
    end
  end
end
