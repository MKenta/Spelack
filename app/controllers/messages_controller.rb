class MessagesController < ApplicationController
  protect_from_forgery secret: [:destroy, :create]
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    @messages = Message.all
    @nickname = current_user.nickname
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      MessageBroadcastJob.perform_later(@message)
      head :ok
    else
      render :index
    end
  end

  def update
    find_by_id
    @message.update_attribute(:text, params[:text])
    head :ok
  end

  def destroy
    find_by_id
    @message.destroy
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:text, :channel_id, :user_id)
  end

  def find_by_id
    @message = Message.find(params[:id])
  end
end
