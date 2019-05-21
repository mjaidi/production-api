class Api::V1::ElementsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :create, :update, :show, :destroy ]
  before_action :find_element, only: [:update, :show, :destroy]

  def index
    @elements = policy_scope(Element)
    render json: ElementsSerializer.new(@elements).serialized_json
  end

  def create
    element = Element.new(element_params)
    if element.save
      render json: {success: true, object: ElementsSerializer.new(element, {params: {full_tree: true}})}
    else
      render json: {success: false, object: nil}
    end
  end

  def show
    render json: ElementsSerializer.new(@element, {params: {full_tree: true}}).serialized_json
  end

  def update
    if @element.update(element_params)
      render json: {success: true, object: ElementsSerializer.new(@element, {params: {full_tree: true}})}
    else
      render json: {success: false, object: nil}
    end
  end

  def destroy
    if @element.destroy
      render json: {success: true, object: @element}
    else
      render json: {success: false, object: nil}
    end
  end

  private

  def element_params
    params.require(:element).permit(:description, :purchase_price_ht, :purchase_tax, :purchase_price_ttc, :sales_price_ht, :sales_tax, :sales_price_ttc, :category, :title, :built, :unit, :type_element)
  end

  def find_element
    @element = Element.find_by_id(params[:id])
  end

end
