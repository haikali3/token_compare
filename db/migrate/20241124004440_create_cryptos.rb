class CreateCryptos < ActiveRecord::Migration[8.0]
  def change
    create_table :cryptos do |t|
      t.string :name
      t.string :symbol
      t.decimal :price
      t.decimal :market_cap
      t.decimal :volume

      t.timestamps
    end
  end
end
