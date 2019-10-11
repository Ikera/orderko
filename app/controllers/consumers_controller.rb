class ConsumersController < ApplicationController
	def index
		@consumers = Consumer.all
		@consumer = Consumer.new
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

	private

	def consumer_params
		params.require(:consumer).permit(:name)
	end
end
