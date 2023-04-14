class Api::V1::RepliesController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    reply = Reply.new(
      reply: reply_params[:reply],
      discussion_id: reply_params[:discussion_id],
      user_id: reply_params[:user_id]
    )
    if reply.save
      render json: reply, status: 200
    else  
      render json: {
        error: "Error creating.."
      }
    end
  end

  def destroy
    reply =Reply.find_by(id: params[:id])
    if reply
      reply.destroy
      render json: "Reply has been deleted"
    end
  end

  def update
    reply = Reply.find_by(id: [params[:id]])
    if reply
      reply.update(reply: params[:reply], discussion_id: params[:discussion_id], user_id: params[:user_id])
      render json: "Reply updated successfully"
    else
      render json: {
        error: "Reply not found"
      }
    end
  end

  def show
    reply = Reply.find_by(id: params[:id])
    if reply
      render json: reply, status: 200
    else  
      render json: {
        error: "Reply not found"
      }
    end
  end

  private

  def reply_params
    params.permit([
      :reply,
      :discussion_id,
      :user_id
    ])
  end
end
