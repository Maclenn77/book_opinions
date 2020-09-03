# This is the UsersController
class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user.nil?
      (redirect_to login_path)
    else
      @followings = current_user.following_users
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = set_user
    @followers = User.last_followers(@user)
    @opinions = @user.opinions.order(created_at: :desc).limit(10)
    @opinion = Opinion.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = set_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in(@user)
        remember(@user)
        format.html { redirect_to root_path, notice: 'User was created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = set_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.includes(:opinions, followees: :follower).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :fullname, :token, :avatar, :cover)
  end
end
