class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.references :project, null: false, foreign_key: true
      t.string :type, null: false
      t.string :author_name
      t.text :content
      t.string :from_status
      t.string :to_status

      t.timestamps
    end
  end
end
