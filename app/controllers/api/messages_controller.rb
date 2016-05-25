class Api::MessagesController < ApplicationController
  def index
    messages = Message.all
    render json: messages.to_json(methods: :nickname)
  end

  def show
    messages = Message.where(message_params).includes(:user)
    render json: messages.to_json(methods: :nickname)
  end

  private

  def message_params
    params.permit(:text, :channel_id, :user_id)
  end
end
