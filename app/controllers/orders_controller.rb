class OrdersController < ApplicationController
  before_action :move_item, only: [:index, :create]
  before_action :move_user, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
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

  def move_user
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id
      redirect_to root_path 
    end
  end

  def move_item
    @item = Item.find(params[:item_id])
     if @item.order.present?
      redirect_to root_path
     end
  end
end
