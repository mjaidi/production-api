class Api::V1::EstimatesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :create, :update, :show, :destroy ]
  before_action :find_estimate, only: [:update, :show, :destroy]

  def index
    @estimates = policy_scope(Estimate)
    render json: EstimatesSerializer.new(@estimates).serialized_json
  end

  def create
    estimate = Estimate.new(estimate_params)
    if estimate.save
      render json: {success: true, object: EstimatesSerializer.new(estimate, {params: {full_tree: true}})}
    else
      render json: {success: false, object: nil}
    end
  end

  def show
    render json: EstimatesSerializer.new(@estimate, {params: {full_tree: true}}).serialized_json
  end

  def update
    if @estimate.update(estimate_params)
      render json: {success: true, object: EstimatesSerializer.new(@estimate, {params: {full_tree: true}})}
    else
      render json: {success: false, object: nil}
    end
  end

  def destroy
    if @estimate.destroy
      render json: {success: true, object: @estimate}
    else
      render json: {success: false, object: nil}
    end
  end

  private

  def estimate_params
    params.require(:estimate).permit(:number, :client, :remise)
  end

  def find_estimate
    @estimate = Estimate.find_by_id(params[:id])
  end

end
