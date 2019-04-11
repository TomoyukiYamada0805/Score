class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :team_id
      t.string  :team_name
      t.string  :team_color
      t.integer :del_flg
      t.timestamps
    end
  end
end
