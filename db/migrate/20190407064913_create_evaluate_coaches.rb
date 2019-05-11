class CreateEvaluateCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluate_coaches do |t|

      t.integer :user_id, :null => false, :limit => 8 
      t.string  :coach_name
      t.float :evaluate_point
      t.text  :evaluate_comment
      t.integer :del_flg
      t.timestamps
    end
  end
end
