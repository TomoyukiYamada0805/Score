class AddShortnameToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :short_name, :string, after: :team_name
  end
end
