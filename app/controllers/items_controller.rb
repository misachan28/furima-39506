class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :item_find, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @category = Category.all
    @condition = Condition.all
    @postage = Postage.all
    @prefecture = Prefecture.all
    @shipping_date = ShippingDate.all
    
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show 
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id
    redirect_to root_path if current_user.id == @item.user_id && @item.purchase
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if current_user.id == @item.user_id
    @item.destroy
    redirect_to root_path
   else
    render :show, status: :unprocessable_entity
   end
  end

  private

  def item_params
    params.require(:item).permit(:image,:nickname,:explanation,:category_id,:condition_id,:postage_id,:prefecture_id,:shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
