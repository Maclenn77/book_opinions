class OpinionsController < ApplicationController
  include SessionsHelper
  before_action :belongs_user, only: %i[edit update destroy]

  # GET /opinions
  # GET /opinions.json
  def index
    unless current_user.nil?
      @opinion = Opinion.new
      @opinions = Opinion.last_opinions(current_user)
      @followers = current_user.who_to_follow
    end
  end

  # GET /opinions/1
  # GET /opinions/1.json
  def show; end

  # GET /opinions/new

  # GET /opinions/1/edit
  def edit; end

  def new;
    @opinion = Opinion.new
  end

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

    # Only allow a list of trusted parameters through.
    def opinion_params
      params.require(:opinion).permit(:title, :body)
    end

    def belongs_user
      unless set_opinion.user == current_user
        redirect_to root_path, notice: 'You only can modify or destroy your own opinions'
      end
    end
end
