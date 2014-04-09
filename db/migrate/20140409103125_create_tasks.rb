class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :assignee, index: true
      t.belongs_to :project, index: true
      t.datetime :due_date
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
