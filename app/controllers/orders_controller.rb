# simple CRUD for orders
class OrdersController < ApplicationController
  LIMIT = 5
  before_action :find_order, only: %i[edit update destroy]
  def index
    @offset = params.fetch(:offset, 0).to_i
    @limit = LIMIT
    @count = Order.count
    @orders = Order.order(created_at: :desc).offset(@offset).limit(@limit)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(safe_order_params.except(:status))
    return render_error unless @order.save

    flash[:notice] = 'Your order is created'
    redirect_to orders_path
  end

  def edit
    @text_messages = @order.text_messages.order(created_at: :desc).limit(LIMIT)
  end

  def update
    return render_error unless @order.update(safe_order_params)

    flash[:notice] = 'The order is updated'
    redirect_to orders_path
  end

  def destroy
    return render_error unless @order.destroy

    flash[:notice] = 'The order is deleted'
    redirect_to orders_path
  end

  private

  def render_error
    flash[:error] = format_errors(@order)
    render :edit, status: :unprocessable_entity
  end

  def safe_order_params
    params.require(:order).permit(:name, :phone, :item, :text_messages_enabled, :status)
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
