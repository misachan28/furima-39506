class PurchaseMailing
  include ActiveModel::Model 
  attr_accessor :user_id, :item_id, :postcode, :phone_number, :prefecture_id, :city, :block, :building, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A[0-9]+\z/}, length: {minimum: 10,maximum:11}
    validates :token
  end
  

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Mailing.create(postcode: postcode, phone_number: phone_number, city: city, block: block, prefecture_id: prefecture_id, purchase_id: purchase.id)
  end
end