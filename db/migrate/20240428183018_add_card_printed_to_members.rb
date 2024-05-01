class AddCardPrintedToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :card_printed, :boolean, default: false
  end
end
