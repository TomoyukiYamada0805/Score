class CreateMatchProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :match_progresses do |t|
      t.integer :match_id, :null => false
      t.integer :team_type, :null => false, :comment => "0:home, 1:away"
      t.integer :progress_type, :null => false
      t.string  :progress_time, :null => false
      t.string  :scorer
      t.string  :yellow_card
      t.string  :red_card
      t.string  :from_change_player
      t.string  :to_change_player
      t.integer :del_flg

      t.timestamps
    end
  end
end
