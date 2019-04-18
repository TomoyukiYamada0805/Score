class AddColumnEvaluateCoach < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluate_coaches, :match_id, :integer, after: :user_id
  end
end
