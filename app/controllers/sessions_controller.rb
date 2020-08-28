# frozen_string_literal: true

# This class controller stays what do when creating, editing, updating
# or destroying opinions
class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  def new
    redirect_to root_path unless current_user.nil?
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user.nil?
      flash[:danger] = []
      unless params[:session][:name].split.empty?
        flash.now[:danger] << 'Invalid name'
      end
      if params[:session][:name].split.empty?
        flash.now[:danger] << 'Name can not be blank'
      end
      render 'new'
    else
      log_in user
      remember user
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
