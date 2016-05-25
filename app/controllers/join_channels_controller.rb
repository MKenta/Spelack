class JoinChannelsController < ApplicationController
  before_action :set_channel, only: :index
  def index
    @channel.users << current_user
    redirect_to channels_path
  end

  private

  def set_channel
    @channel = Channel.friendly.find(params[:id])
  end
end
