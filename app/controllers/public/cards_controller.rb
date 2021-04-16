class Public::CardsController < ApplicationController
  require 'payjp'

  before_action :authenticate_user!
  before_action :set_payjp_secret_key, except: :new
  before_action :set_card, only: [:new, :show, :destroy]

  # プラン作成
  def plan
    Payjp::Plan.create(
      :amount => 8000,
      :interval => 'month',
      :billing_day => 27,
      :currency => 'jpy',
    )
  end

  def new
    redirect_to action: "show" if @card.present?
    @card = Card.new
  end

  def show
    redirect_to action: 'new' if @card.blank?
    customer = Payjp::Customer.retrieve(@card.customer_id)
    default_card_information = customer.cards.retrieve(@card.card_id)
    @card_info = customer.cards.retrieve(@card.card_id)
    @exp_month = default_card_information.exp_month.to_s
    @exp_year = default_card_information.exp_year.to_s.slice(2,3)
    @card_brand = default_card_information.brand
  end

  def create
    if params['payjp-token'].blank?
      redirect_to action: 'new'
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token']
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        # 保存できたらpayアクションを呼び出す
        pay
      else
        flash[:danger] = 'カード情報を登録できませんでした。'
        redirect_to action: 'new'
      end
    end
  end

  def pay
    card = Card.find(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    subscription = Payjp::Subscription.create(
      :customer => card.customer_id,
      :plan => plan,
      :metadata => { user_id: current_user.id }
    )
    current_user.update(subscription_id: subscription.id, is_payed: true)
    redirect_to mypage_path, notice: '定期決済の処理が完了致しました。これからさまざまなレッスンをお楽しみください。'
  end

  def cancel
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    subscription = Payjp::Subscription.retrieve(current_user.subscription_id)
    subscription.cancel
    current_user.update(is_payed: false)
    redirect_to mypage_path, notice: '定期決済が解除されました。以降レッスンのご受講はできません。再度受講したくなった際は、もう一度決済手続きから始めて頂くようお願い致します。'
  end

  def destroy
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card.destroy
    customer.delete
    redirect_to mypage_path, notice: 'クレジットカードが削除されました。'
  end

  private

  def set_payjp_secret_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

end
