class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update]
  def index
    @channels = Channel.all
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to channel_path(@channel)
    else
      render :new
    end
  end

  def show
  end

  def update
    if @channel.update(channel_params)
      redirect_to channel_path(@channel)
    else
      render :edit
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :status, :author_id)
  end
end