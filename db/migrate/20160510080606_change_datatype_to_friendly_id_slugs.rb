class ChangeDatatypeToFriendlyIdSlugs < ActiveRecord::Migration
  def change
    change_column :friendly_id_slugs, :slug, :string, limit: 190
    change_column :friendly_id_slugs, :scope, :string, limit: 190
  end
end
