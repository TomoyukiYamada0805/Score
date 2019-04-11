class CreateMatchInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :match_infos do |t|
      t.integer :match_id, :null => false
      t.integer :team_type, :null => false, :comment => "0:home, 1:away"
      t.integer :team_id, :null => false
      t.string  :first_point, :null => false
      t.string  :second_point, :null => false
      t.integer :control_rate
      t.integer :shoot_count
      t.integer :frame_count
      t.integer :mileage
      t.integer :sprint_count
      t.integer :pass_count
      t.integer :pass_success_rate
      t.integer :offside
      t.integer :freekick_count
      t.integer :cornerkick_count
      t.integer :penalty_kick
      t.integer :del_flg

      t.timestamps
    end
  end
end
