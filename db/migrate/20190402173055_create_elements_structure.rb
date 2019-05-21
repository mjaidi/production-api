class CreateElementsStructure < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.string :title
      t.string :description
      t.string :category
      t.string :unit
      t.string :type_element
      t.boolean :built
      t.float :sales_price_ht
      t.float :sales_tax
      t.float :sales_price_ttc
      t.float :purchase_price_ht
      t.float :purchase_tax
      t.float :purchase_price_ttc
      t.string :legacy_ref

      t.timestamps
    end

    create_table :join_elements do |t|
      t.bigint :element_parent_id
      t.bigint :element_child_id
      t.float :quantity

      t.index :element_parent_id
      t.index :element_child_id

      t.timestamps
    end

    create_table :suppliers do |t|
      t.string :name

      t.timestamps
    end

    create_table :element_suppliers do |t|
      t.references :elements
      t.references :suppliers
      t.float :purchase_price_ht
      t.float :purchase_tax
      t.float :purchase_price_ttc

      t.timestamps
    end

    create_table :estimates do |t|
      t.string :number
      t.float :remise
      t.string :client

      t.timestamps
    end

    create_table :estimate_elements do |t|
      t.references :element
      t.references :estimate
      t.float :quantity

      t.timestamps
    end
  end
end
