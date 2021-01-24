class AddOrderToPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_methods, :order, :integer, null: false
  end
end
