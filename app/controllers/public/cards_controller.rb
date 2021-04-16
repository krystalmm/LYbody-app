class Public::CardsController < ApplicationController
  require 'payjp'

  before_action :authenticate_user!
  before_action :set_api_key

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
    card = Card.find(user_id: current_user.id)
    redirect_to action: "show" if card.present?
  end

  def show
    @card = Card.find(user_id: current_user.id)
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

  private

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
  end

end
