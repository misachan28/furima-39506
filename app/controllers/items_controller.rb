class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # @items = Item.all
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


  private

  def item_params
    params.require(:item).permit(:image,:nickname,:explanation,:category_id,:condition_id,:postage_id,:prefecture_id,:shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
