class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.date :date_of_comment
      t.belongs_to :article

      t.timestamps
    end
  end
end
