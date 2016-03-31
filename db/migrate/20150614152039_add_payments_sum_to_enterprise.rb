class AddPaymentsSumToEnterprise < ActiveRecord::Migration
  def change
    add_column :enterprises, :payments_sum, :float, :default => 0
  end
end
