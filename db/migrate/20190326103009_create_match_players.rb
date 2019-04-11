class CreateMatchPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :match_players do |t|
      t.integer :match_id, :null => false
      t.integer :player_id
      t.integer :team_type, :null => false, :comment => "0:home, 1:away"
      t.integer :player_type, :null => false, :comment => "0: 選手, 1: 監督, 2: 審判"
      t.string  :player_name, :comment => "監督、審判の名前を入れる"
      t.integer :starting_flg, :default => 0, :comment => "スターティングメンバー:1"
      t.string  :player_change
      t.string  :position
      t.integer :sort_no
      t.integer :del_flg

      t.timestamps
    end
  end
end
