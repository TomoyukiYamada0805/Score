class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :match_id, :null => false
      t.integer :league_type, :null => false
      t.integer :section, :null => false
      t.string  :match_date, :null => false
      t.integer :del_flg

      t.timestamps
    end
  end
end
