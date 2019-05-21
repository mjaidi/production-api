class Api::V1::JoinElementsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :destroy, :create, :update ]
  before_action :find_element, only: [:create]
  before_action :find_join_element, only: [:update, :destroy]

  def create
    join_element = JoinElement.new(join_element_params)
    if join_element.save
      render json: {success: true, object: join_element}
    else
      render json: {success: false, object: nil}
    end
  end

  def update
    if @join_element.update(join_element_params)
      render json: {success: true, object: @join_element}
    else
      render json: {success: false, object: nil}
    end
  end

  def destroy
    if @join_element.destroy
      render json: {success: true, object: @join_element}
    else
      render json: {success: false, object: nil}
    end
  end

  private

  def join_element_params
    params.require(:join_element).permit(:element_parent_id, :element_child_id, :quantity)
  end

  def find_element
    @element = Element.find_by_id(params[:element_id])
  end

  def find_join_element
    @join_element = JoinElement.find_by_id(params[:id])
  end
end
