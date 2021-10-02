class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :text, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :sipping_day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def move_index
    @item = Item.find(params[:id])
    redirect_to action: :index unless @item.user.id == current_user.id
  end
end
