class OpinionsController < ApplicationController
  include SessionsHelper
  before_action :set_opinion, only: [:show, :edit, :update, :destroy]

  # GET /opinions
  # GET /opinions.json
  def index
    @opinion = Opinion.new
    @opinions = if current_user
                  timeline_opinions(current_user.followed)
                else
                  Opinion.includes(:user).all.desc
                end
    @last_users = User.last_users if current_user.nil?
    @followers = current_user.who_to_follow
  end

  # GET /opinions/1
  # GET /opinions/1.json
  def show
  end

  # GET /opinions/new

  # GET /opinions/1/edit
  def edit; end

  def new; end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = current_user.opinions.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        format.html { redirect_to root_path, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
  def update
    @opinion = set_opinion

    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to root_path, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Opinion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

    def timeline_opinions(list_of_followees)
      timeline_opinions = Opinion.includes(:user).user_opinions(current_user)
      list_of_followees.each do |followee|
        timeline_opinions += Opinion.includes(:user).user_opinions(followee)
      end
      timeline_opinions
    end

    # Only allow a list of trusted parameters through.
    def opinion_params
      params.require(:opinion).permit(:title, :body)
    end
end
