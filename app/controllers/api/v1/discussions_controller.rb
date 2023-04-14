class Api::V1::DiscussionsController < ApplicationController

  before_action :doorkeeper_authorize!
  skip_before_action :verify_authenticity_token
  respond_to :json
  
  def index
    discussions = Discussion.all
    render json: discussions, status: 200
  end

  def show
    discussion = Discussion.find_by(id: params[:id])
    if discussion
      render json: discussion, status: 200
    else   
      render json: {
        error: "Discussion not found"
      }
    end
  end

  def create
    discussion = Discussion.new(
      title: discussion_params[:title],
      content: discussion_params[:content],
      user_id: discussion_params[:user_id],
      channel_id: discussion_params[:channel_id]
    )
    if discussion.save
      render json: discussion, status: 200
    else 
      render json: {
        error: "Error Creating.."
      }
    end
  end

  def update
    discussion = Discussion.find_by(id: [params[:id]])
    if discussion
      discussion.update(title: params[:title], content: params[:content], user_id: params[:user_id], channel_id: params[:channel_id])
      render json: "Discussion updated successfully"
    else        
      render json: {
        error: "Discussion not found"
      }
    end
  end

  def destroy
    discussion = Discussion.find_by(id: params[:id])
    if discussion
      discussion.destroy
      render json: "Discussion has been deleted"
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit([
      :title,
      :content,
      :user_id,
      :channel_id
    ])
  end
end
