class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :find, only:[:show,:edit,:update]
  before_action :move_index, only: [:edit]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :sipping_day_id,:price).merge(user_id: current_user.id)
  end

  def move_index
    unless @item.user.id == current_user.id
      redirect_to action: :index 
    end
  end

  def find
    @item =Item.find(params[:id])
  end
end
