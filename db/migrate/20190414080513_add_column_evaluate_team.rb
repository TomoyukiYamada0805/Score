class AddColumnEvaluateTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluate_teams, :match_id, :integer, after: :user_id
  end
end
