class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchasemailing = PurchaseMailing.new
    redirect_to root_path if current_user.id == @item.user_id
    redirect_to root_path if current_user.id != @item.user_id && @item.purchase
  end

  def create
    @purchasemailing =PurchaseMailing.new(purchase_params)
    if @purchasemailing.valid?
      pay_item
      @purchasemailing.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  
  private 
  
  def purchase_params
    params.require(:purchase_mailing).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: item_find[:price], 
        card: purchase_params[:token], 
        currency: 'jpy'
      )   
  end

end

