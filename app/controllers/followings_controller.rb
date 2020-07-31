class FollowingsController < ApplicationController
  def create
    @following = Following.new(follower_id: params[:user_id], followee_id: params[:followee_id])
    redirect_to user_followings_path, notice: 'You followed' if @following.save
  end

  def destroy
    following = following.find_by(id: params[:id], followee: user, follower: params[:current_user.id])
    following&.destroy
    redirect_to root_path, notice: 'You Unfollow this user.'
  end


end
