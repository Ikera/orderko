class OrdersController < ApplicationController
  before_action :find_order, only: [:update, :destroy]

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to daily_offer_path(@order.daily_offer), notice: 'One order successfully created' }
        format.js
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { redirect_to daily_offer_path(@order.daily_offer), alert: "#{@order.errors.full_messages.join(',')}" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @order.update(params.require(:order).permit(:meal_paid, :shipping_paid))
      redirect_to cashier_daily_offer_path(@order.daily_offer), notice: "#{@order.consumer.name}'s order successfully updated"
    else
      redirect_to cashier_daily_offer_path(@order.daily_offer), alert: "Something went wrong"
    end
  end

  def destroy
    daily_offer = @order.daily_offer
    @order.destroy
    redirect_to daily_offer_path(daily_offer), notice: "Order successfully deleted."
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:consumer_id, :daily_offer_id, :number_of_meals)
  end
end
