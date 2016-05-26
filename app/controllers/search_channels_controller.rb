class SearchChannelsController < ApplicationController
  before_action :search_channels, only: [:index]

  def index
  end

  private

  def search_channels
    @channels = Channel.search(params[:query])
  end
end
