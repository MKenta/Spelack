class DirectMessagesController < ApplicationController
  before_action :search_users, only: [:index]
  before_action :set_dm_channels, only: [:index, :create]
  before_action :set_params, only: [:create]
  def index
  end

  def create
    if @dm_channels.find { |n| n[:name] == @dm_params[:name] }
      redirect_to channels_path
    else
      @channel = Channel.new(@dm_params)
      if @channel.save
        current_user.channels << @channel
        @user.channels << @channel
        redirect_to channel_path(@channel)
      else
        render :index
      end
    end
  end

  private

  def set_params
    user = params.require(:user).permit(:user_id)
    @user = User.find(user[:user_id])
    @channel_name = [@user.nickname, current_user.nickname].sort.join('-')
    @dm_params = {
      name: @channel_name,
      status: 2,
      author_id: current_user.id,
    }
  end

  def search_users
    @users = User.search(params[:query], current_user)
  end

  def set_dm_channels
    @dm_channels = current_user.channels.where(status: 2)
  end
end
