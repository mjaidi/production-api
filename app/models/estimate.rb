class Estimate < ApplicationRecord
  has_many :estimate_elements
  has_many :elements, through: :estimate_elements

  def estimate_elements_info
    estimate_elements.map do |ee|
      {info: ee.element, quantity: ee.quantity, join_id: ee.id, cost: (ee.element.element_cost*ee.quantity unless ee.element.nil? || ee.quantity.nil?)}
    end
  end

  def estimate_cost
    cost_array = estimate_elements.map do |ee|
      ee.element.element_cost*ee.quantity unless ee.element.nil? || ee.quantity.nil?
    end
    cost_array.compact.sum unless cost_array[0].nil?
  end

  def composition_mp
    mp_array = []
    # Get all matière première for each estimate element - multiply by quantity and store in an array
    estimate_elements.each do |ee|
       ee.element.element_mps.each {|mp|  mp_array << {info: mp[:info], quantity: (mp[:quantity] * ee.quantity), cost: (mp[:cost] * ee.quantity)} } unless ee.element.nil?
    end

    # Combine and add values of each matière première into a flattend combined array of composition
    combined_mps = []
    mp_array.flatten.each do |mp|
      if combined_mps.select {|cm| cm[:info] == mp[:info]} != []
        cm_index = combined_mps.index {|cm| cm[:info] == mp[:info]}
        combined_mps[cm_index][:quantity] = combined_mps[cm_index][:quantity] + mp[:quantity]
        combined_mps[cm_index][:cost] = combined_mps[cm_index][:cost] + mp[:cost]
      else
        combined_mps << mp
      end
    end
    return combined_mps
  end
end
