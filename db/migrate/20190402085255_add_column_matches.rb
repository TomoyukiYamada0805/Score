class AddColumnMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :home_team_id, :integer, after: :section
    add_column :matches, :away_team_id, :integer, after: :home_team_id
  end
end
