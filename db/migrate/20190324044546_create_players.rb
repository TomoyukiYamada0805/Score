class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.integer :player_type, :null => false, :comment => "0: 選手, 1: 監督, 2: 審判"
      t.integer :player_id
      t.integer :team_id
      t.string  :player_name
      t.integer :profile_number
      t.string  :position
      t.integer :del_flg

      t.timestamps
    end
  end
end
