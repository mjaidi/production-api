class Element < ApplicationRecord
  has_many :parents, class_name: 'JoinElement', foreign_key: :element_child_id, dependent: :destroy
  has_many :children, class_name: 'JoinElement', foreign_key: :element_parent_id,  dependent: :destroy

  has_many :estimate_elements
  has_many :estimates, through: :estimate_elements

  has_many :element_suppliers
  has_many :suppliers, through: :element_suppliers

  def child_elements(multiplyer = 1)
    children.map do |join_element|
      join_multiplyer = multiplyer * join_element.quantity
      {child: {info: join_element.child_element, quantity: join_element.quantity, cost: join_element.join_cost.round(2), join_id: join_element.id, multiplyer: join_multiplyer}, grandchildren: (join_element.child_element.child_elements(join_multiplyer) unless join_element.child_element.nil?)}
    end
  end

  def direct_parents
    parents.map {|join_element| join_element.parent_element}
  end

  def element_cost
    return purchase_price_ht unless built
    children.sum {|join_element| join_element.join_cost}
  end

  def element_mps(mp_array = [], quantity = 0, cost = 0, child_mutltiplier = 1, ch_multiplyer = 1)
    # Recussively loop through child_elements to build array of 'basic' elements from the tree
    if child_elements == []
      mp_array << {info: self, quantity: (quantity * child_mutltiplier), cost: (cost * child_mutltiplier) }
    else
      child_elements.each do |child|
        if child[:grandchildren] == []
          mp_array << {info: child[:child][:info], quantity: (child[:child][:quantity] * ch_multiplyer), cost: (child[:child][:cost] * ch_multiplyer) }
        else
          child[:grandchildren].each { |ch| ch[:child][:info].element_mps(mp_array, ch[:child][:quantity], ch[:child][:cost], child[:child][:multiplyer], ch[:child][:multiplyer]) }
        end
      end
    end
    return mp_array
  end
end
