class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, :business_id
      t.integer :rating
      t.string :body
      t.timestamps
    end
  end
end
