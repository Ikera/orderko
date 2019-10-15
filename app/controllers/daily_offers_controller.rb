class DailyOffersController < ApplicationController
  before_action :find_daily_offer, only: [:show, :open, :close, :cashier]

  def index
    @daily_offers = DailyOffer.order(day: :desc).last(25)
  end

  def show
  end

  def create
    @daily_offer = DailyOffer.new(daily_offer_params)

    respond_to do |format|
      if @daily_offer.save
        format.html { redirect_to @daily_offer, notice: 'Thanks Goran, that sounds delicious.' }
        format.js
        format.json { render json: @daily_offer, status: :created, location: @daily_offer }
      else
        format.html { redirect_to root_path, alert: "#{@daily_offer.errors.full_messages.join(',')}" }
        format.json { render json: @daily_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def open
    @daily_offer.update(closed: false)
    redirect_to @daily_offer
  end

  def close
    @daily_offer.update(closed: true)
    redirect_to @daily_offer
  end

  def cashier
    @previous_daily_offer = DailyOffer.find_by_day(@daily_offer.day - 1.day)
    @next_daily_offer = DailyOffer.find_by_day(@daily_offer.day + 1.day)
  end

  private

  def find_daily_offer
    @daily_offer = DailyOffer.find(params[:id])
  end

  def daily_offer_params
    params.require(:daily_offer).permit(:name, :day, :price, :shipping)
  end
end
