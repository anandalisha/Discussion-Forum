class Api::V1::LikesController < ApplicationController
 
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    like = Like.new(
      likeable_id: like_params[:likeable_id],
      likeable_type: like_params[:likeable_type]
    )
    if like.save
      render json: like, status: 200
    else  
      render json: {
        error: "Error creating.."
      }
    end
  end

  def destroy
    like = Like.find_by(id: params[:id])
    if like
      like.destroy
      render json: "Like has been deleted"
    end
  end

  private

  def like_params
    params.permit([
      :likeable_id,
      :likeable_type
    ])
  end
end
