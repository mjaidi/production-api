# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Element.destroy_all

# e1 = Element.create!(title: 'Beurre', type_element: 'MP', unit: 'Kg', category: 'Ingrédients', built: false, purchase_price_ht: 55, purchase_tax: 0.2)
# e2 = Element.create!(title: 'Farine Fleur Kayna', unit: 'Kg', type_element: 'MP', category: 'Ingrédients', built: false, purchase_price_ht: 9.3, purchase_tax: 0.2)
# e3 = Element.create!(title: 'Farine Finot Kayna', unit: 'Kg', type_element: 'MP', category: 'Ingrédients', built: false, purchase_price_ht: 12.33, purchase_tax: 0.2)
# e4 = Element.create!(title: 'Sucre Glace', unit: 'Kg', type_element: 'MP', category: 'Ingrédients', built: false, purchase_price_ht: 9.4, purchase_tax: 0.2)
# e5 = Element.create!(title: 'Biscuit Beurre SF 1Kg', unit: 'Kg', type_element: 'Semi Fini', category: 'Semi Fini Biscuits', built: true, purchase_price_ht: 9.4, purchase_tax: 0.2)

# e6 = Element.create!(title: 'Carton 150gr', unit: 'unité', type_element: 'MP', category: 'Packaging', built: false, purchase_price_ht: 2.3, purchase_tax: 0.2)
# e7 = Element.create!(title: 'Sac Film Alu', unit: 'unité', type_element: 'MP', category: 'Packaging', built: false, purchase_price_ht: 0.62, purchase_tax: 0.2)
# e8 = Element.create!(title: 'Rond Vinyl', unit: 'unité', type_element: 'MP', category: 'Packaging', built: false, purchase_price_ht: 0.11, purchase_tax: 0.2)
# e9 = Element.create!(title: 'Biscuit Beurre Carton 150gr', unit: 'unité', type_element: 'Fini', category: 'Biscuits Carton', built: true, sales_price_ttc: 30, sales_price_ht: 25, sales_tax: 0.2)
# e10 = Element.create!(title: 'Biscuit Confiture Carton 150gr', unit: 'unité', type_element: 'Fini', category: 'Biscuits Carton', built: true, sales_price_ttc: 30, sales_price_ht: 25, sales_tax: 0.2)
# e11 = Element.create!(title: 'Coffret Carton', unit: 'unité', type_element: 'Fini', category: 'Biscuits Carton', built: true, sales_price_ttc: 30, sales_price_ht: 25, sales_tax: 0.2)

# j1 = JoinElement.new
# j1.parent_element = e5
# j1.child_element = e1
# j1.quantity = 0.393
# j1.save

# j2 = JoinElement.new
# j2.parent_element = e5
# j2.child_element = e2
# j2.quantity = 0.357
# j2.save

# j3 = JoinElement.new
# j3.parent_element = e5
# j3.child_element = e3
# j3.quantity = 0.143
# j3.save

# j4 = JoinElement.new
# j4.parent_element = e5
# j4.child_element = e4
# j4.quantity = 0.143
# j4.save

# j5 = JoinElement.new
# j5.parent_element = e9
# j5.child_element = e5
# j5.quantity = 0.15
# j5.save

# j6 = JoinElement.new
# j6.parent_element = e9
# j6.child_element = e6
# j6.quantity = 1
# j6.save

# j7 = JoinElement.new
# j7.parent_element = e9
# j7.child_element = e7
# j7.quantity = 1
# j7.save

# j8 = JoinElement.new
# j8.parent_element = e9
# j8.child_element = e8
# j8.quantity = 1
# j8.save

# j9 = JoinElement.new
# j9.parent_element = e11
# j9.child_element = e9
# j9.quantity = 2
# j9.save

# j10 = JoinElement.new
# j10.parent_element = e11
# j10.child_element = e10
# j10.quantity = 2
# j10.save

require 'creek'

puts 'cleaning db'
EstimateElement.destroy_all
Estimate.destroy_all
JoinElement.destroy_all
Element.destroy_all

puts '✅ clean successful'

puts 'Seeding Element data'

ing_d = Creek::Book.new './db/ingredients.xlsx'
pack_d = Creek::Book.new './db/packaging.xlsx'
recette_d = Creek::Book.new './db/recettes.xlsx'
puts "✅ success Reading Excel file "

ing = ing_d.sheets[0]
pack = pack_d.sheets[0]
recette = recette_d.sheets[0]
puts "✅ success Reading sheets "

ing.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if el["B#{index + 1}"].nil?
  Element.create(
    legacy_ref: el["A#{index + 1}"],
    title: el["B#{index + 1}"],
    category: el["C#{index + 1}"],
    type_element: 'MP',
    unit: el["D#{index + 1}"],
    purchase_tax: el["E#{index + 1}"],
    purchase_price_ht: el["F#{index + 1}"],
    built: false,
  )
end

puts "✅ success Creating ingredients from spread sheet "

pack.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if el["B#{index + 1}"].nil?
  Element.create(
    legacy_ref: el["A#{index + 1}"],
    title: el["B#{index + 1}"],
    category: el["C#{index + 1}"],
    type_element: 'MP',
    unit: el["D#{index + 1}"],
    purchase_tax: el["E#{index + 1}"],
    purchase_price_ht: el["F#{index + 1}"],
    built: false,
  )
end

puts "✅ success Creating packaging from spread sheet "

recette.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if el["B#{index + 1}"].nil?
  Element.create(
    legacy_ref: el["A#{index + 1}"],
    title: el["B#{index + 1}"],
    category: el["C#{index + 1}"],
    type_element: (el["H#{index + 1}"] == 'Oui' ? 'Produit Semi Fini' : 'Produit Fini'),
    unit: el["D#{index + 1}"],
    sales_tax: el["E#{index + 1}"],
    sales_price_ht: el["F#{index + 1}"],
    sales_price_ttc: el["G#{index + 1}"],
    built: true,
  )
end

puts "✅ success Creating recepies from spread sheet "

puts 'Seeding Join Element data'

join_ing_d = Creek::Book.new './db/join_ing.xlsx'
join_pack_d = Creek::Book.new './db/join_pack.xlsx'
join_base_d = Creek::Book.new './db/join_base.xlsx'
puts "✅ success Reading Excel file "

join_ing = join_ing_d.sheets[0]
join_pack = join_pack_d.sheets[0]
join_base = join_base_d.sheets[0]

puts "✅ success Reading sheets "

join_ing.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if Element.find_by_legacy_ref(el["B#{index + 1}"]).nil?
  next if Element.find_by_legacy_ref(el["A#{index + 1}"]).nil?
  JoinElement.create(
    element_child_id: Element.find_by_legacy_ref(el["A#{index + 1}"]).id,
    element_parent_id: Element.find_by_legacy_ref(el["B#{index + 1}"]).id,
    quantity: el["C#{index + 1}"],
  )
end

puts "✅ success Creating ingredient joins from spread sheet "

join_pack.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if Element.find_by_legacy_ref(el["B#{index + 1}"]).nil?
  next if Element.find_by_legacy_ref(el["A#{index + 1}"]).nil?
  JoinElement.create(
    element_child_id: Element.find_by_legacy_ref(el["A#{index + 1}"]).id,
    element_parent_id: Element.find_by_legacy_ref(el["B#{index + 1}"]).id,
    quantity: el["C#{index + 1}"],
  )
end

puts "✅ success Creating packaging joins from spread sheet "

join_base.rows.each_with_index do |el, index|
  # skipping first rows only containing titles no data
  next if index + 1 < 2
  next if Element.find_by_legacy_ref(el["B#{index + 1}"]).nil?
  next if Element.find_by_legacy_ref(el["A#{index + 1}"]).nil?
  JoinElement.create(
    element_child_id: Element.find_by_legacy_ref(el["A#{index + 1}"]).id,
    element_parent_id: Element.find_by_legacy_ref(el["B#{index + 1}"]).id,
    quantity: el["C#{index + 1}"],
  )
end

puts "✅ success Creating base joins from spread sheet "
