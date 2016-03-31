class AddSanctionsCountToEnterprise < ActiveRecord::Migration
  def change
    add_column :enterprises, :sanctions_count, :integer, :default => 0
  end
end
