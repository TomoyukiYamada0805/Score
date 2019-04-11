class CreateEvaluateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluate_matches do |t|
      t.integer :user_id, :null => false, :limit => 8 
      t.integer :match_id
      t.integer :del_flg

      t.timestamps
    end
  end
end
