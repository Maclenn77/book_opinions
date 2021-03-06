# This Opinion class controller give what do when creating, editing, updating
# or destroying opinions
class OpinionsController < ApplicationController
  include SessionsHelper
  before_action :belongs_user, only: %i[edit update destroy]

  # GET /opinions
  # GET /opinions.json
  def index
    if current_user.nil?
      nil
    else
      @opinion = Opinion.new
      @opinions = Opinion.last_opinions(current_user)
      @followers = User.who_to_follow(current_user)
    end
  end

  # GET /opinions/1
  # GET /opinions/1.json
  def show; end

  # GET /opinions/new

  # GET /opinions/1/edit
  def edit; end

  def new
    @opinion = current_user.opinions.new
  end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = current_user.opinions.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        format.html { redirect_to root_path, notice: 'Opinion was created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to root_path, notice: 'Opinion was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Opinion was destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opinion
    @opinion = Opinion.includes(:user).find(params[:id])
    @user = @opinion.user
    @followers = User.last_followers(@user)
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:title, :body)
  end

  def belongs_user
    set_opinion
    if @opinion.user == current_user
      @opinion
    else
      redirect_to root_path, notice: 'You only can modify your own opinions'
    end
  end
end
