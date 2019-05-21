class Api::V1::EstimateElementsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :destroy, :create, :update ]
  before_action :find_estimate, only: [:create]
  before_action :find_estimate_elements, only: [:update, :destroy]

  def create
    estimate_element = EstimateElement.new(estimate_elements_params)
    if estimate_element.save
      render json: {success: true, object: estimate_element}
    else
      render json: {success: false, object: nil}
    end
  end

  def update
    if @estimate_element.update(estimate_elements_params)
      render json: {success: true, object: @estimate_element}
    else
      render json: {success: false, object: nil}
    end
  end

  def destroy
    if @estimate_element.destroy
      render json: {success: true, object: @estimate_element}
    else
      render json: {success: false, object: nil}
    end
  end

  private

  def estimate_elements_params
    params.require(:estimate_element).permit(:element_id, :estimate_id, :quantity)
  end

  def find_estimate
    @estimate = Estimate.find_by_id(params[:estimate_id])
  end

  def find_estimate_elements
    @estimate_element = EstimateElement.find_by_id(params[:id])
  end
end
