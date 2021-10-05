class OrdersController < ApplicationController
  before_action :found, only: [:index, :create]
  before_action :move_item, only: [:index, :create]
  before_action :move_user, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipalities, :block_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def found
    @item = Item.find(params[:item_id])
  end

  def move_user
    redirect_to root_path if @item.user_id == current_user.id
  end

  def move_item
    redirect_to root_path if @item.order.present?
  end
end
