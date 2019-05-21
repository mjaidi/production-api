class Supplier < ApplicationRecord
  has_many :element_suppliers
  has_many :elements, through: :element_suppliers
end
