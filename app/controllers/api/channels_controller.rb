class Api::ChannelsController < ApplicationController
  def index
    @joined = current_user.channels.without_soft_destroyed
    render json: @joined
  end
end
