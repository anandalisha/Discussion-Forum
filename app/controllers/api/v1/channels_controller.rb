class Api::V1::ChannelsController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    channel = Channel.new(
      channel: channel_params[:channel]
    )
    if channel.save
      render json: channel, status: 200
    else  
      render json: {
        error: "Error creating.."
      }
    end
  end

  def destroy
    channel = Channel.find_by(id: params[:id])
    if channel
      channel.destroy
      render json: "Channel has been destroyed"
    end
  end

  def update
    channel = Channel.find_by(id: [params[:id]])
    if channel
      channel.update(channel: params[:channel], discussion_id: params[:discussion_id])
      render json: "Channel updated successfully"
    else  
      render json: {
        error: "Channel not found"
      }
    end
  end

  def show
    channel = Channel.find_by(id: params[:id])
    if channel
      render json: channel, status: 200
    else 
      render json: {
        error: "Channel not found"
      }
  end
end

private

def channel_params
  params.permit([
    :channel,
    :discussion_id
  ])
  end
end
