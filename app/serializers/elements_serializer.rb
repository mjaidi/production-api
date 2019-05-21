class ElementsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :purchase_price_ht, :purchase_tax, :purchase_price_ttc, :sales_price_ht, :sales_tax, :sales_price_ttc, :category, :title, :built, :unit, :type_element

  attribute :child_elements do |object, params|
    object.child_elements if params && params[:full_tree]
  end

  attribute :element_cost do |object, params|
    if params && params[:full_tree]
      object.element_cost.round(2) unless object.element_cost.nil?
    end
  end

  attribute :direct_parents do |object, params|
    object.direct_parents if params && params[:full_tree]
  end
end
