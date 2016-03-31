class AddSanctionOrganToSanctions < ActiveRecord::Migration
  def change
    add_column :sanctions, :sanction_organ, :string, :default => ""
    remove_column :enterprises, :sanction_organ
  end 
end
