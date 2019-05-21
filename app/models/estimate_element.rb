class EstimateElement < ApplicationRecord
  belongs_to :element, optional: true
  belongs_to :estimate
end
