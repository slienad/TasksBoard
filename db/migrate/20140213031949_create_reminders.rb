class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.text :description
      t.date :due
      t.date :issued
      t.date :updated
      t.integer :status
      t.integer :priority
      t.string :issuer

      t.timestamps
    end
  end
end
