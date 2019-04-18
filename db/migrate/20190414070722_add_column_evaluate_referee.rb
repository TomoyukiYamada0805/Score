class AddColumnEvaluateReferee < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluate_referees, :match_id, :integer, after: :user_id
  end
end
