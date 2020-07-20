class CreateSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :specialities do |t|
      t.string :title, limit: 40

      t.timestamps
    end
  end
end
