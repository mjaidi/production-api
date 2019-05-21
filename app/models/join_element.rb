class JoinElement < ApplicationRecord
  belongs_to :child_element, class_name: "Element", foreign_key: :element_child_id,  optional: true
  belongs_to :parent_element, class_name: "Element", foreign_key: :element_parent_id

  def join_cost
    child_element.nil? ? 0 : child_element.element_cost*(quantity || 0)
  end
end
