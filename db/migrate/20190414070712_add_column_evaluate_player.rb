class AddColumnEvaluatePlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluate_players, :match_id, :integer, after: :user_id
  end
end
