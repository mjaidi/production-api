class EstimatesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :number, :remise, :client, :created_at

  attribute :estimate_elements_info do |object, params|
    object.estimate_elements_info if params && params[:full_tree]
  end
  attribute :estimate_cost do |object, params|
    object.estimate_cost if params && params[:full_tree]
  end
  attribute :composition_mp do |object, params|
    object.composition_mp if params && params[:full_tree]
  end
end
