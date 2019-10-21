class ConsumersController < ApplicationController
  def index
    @consumers = Consumer.all.order(:name)
    @consumer = Consumer.new
    @previous_week = params[:week].present? ? params[:week].to_date - 7.days : Date.today - 7.days
    @next_week = params[:week].present? ? params[:week].to_date + 7.days : Date.today + 7.days
  end

  def create
    @consumer = Consumer.new(consumer_params)

    respond_to do |format|
      if @consumer.save
        format.html { redirect_to @consumer, notice: 'consumer was successfully created.' }
        format.js
        format.json { render json: @consumer, status: :created, location: @consumer }
      else
        format.html { redirect_to consumers_path, alert: "#{@consumer.errors.full_messages.join(',')}" }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @consumer = Consumer.where('lower(name) = ?', params[:id].downcase).first
    redirect_to consumers_path, alert: "Not allowed" if @consumer.nil?
  end

  def update
    @consumer = Consumer.find(params[:id])
    if @consumer.update(consumer_params)
      redirect_to consumer_path(id: @consumer.name.downcase), notice: 'Consumer was successfully updated.'
    else
      redirect_to consumer_path(id: @consumer.name.downcase), alert: "#{@consumer.errors.full_messages.join(',')}"
    end
  end

  def pay_bills
    @consumer = Consumer.find(params[:id])
    cash = @consumer.cash
    @consumer.pay_all_bills
    redirect_to consumer_path(id: @consumer.name.downcase), notice: "Bills successfully payed. #{@consumer.cash} cash left."
  end

  private

  def consumer_params
    params.require(:consumer).permit(:name, :cash)
  end
end
