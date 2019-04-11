class CreateMatchReferees < ActiveRecord::Migration[5.2]
  def change
    create_table :match_referees do |t|
      t.integer :match_id, :null => false
      t.string  :referee_name, :null => false
      t.integer :referee_type, :null => false
      t.integer :del_flg

      t.timestamps
    end
  end
end
