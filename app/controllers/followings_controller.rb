# frozen_string_literal: true

# This class controller stays what do when creating, editing, updating
# or destroying opinions
class FollowingsController < ApplicationController
  def create
    @following = Following.new(follower_id: params[:user_id],
                               followee_id: params[:followee_id])
    redirect_to root_path, notice: 'You followed' if @following.save
  end

  def destroy
    following = Following.find_by(id: params[:id])
    following&.destroy
    redirect_to root_path, notice: 'You Unfollow this user.'
  end

  private

  def following_params
    params.require(:following).permit(:follower_id, :followee_id)
  end
end
