class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @games = if params[:query].present?
               Game.search(query: {
                 multi_match: {
                   query: params[:query],
                   fields: [:title, :description],
                   type: 'phrase_prefix'
                 }
               }).records.to_a
             else
               Game.all
             end

    if params[:min_price].present? && params[:max_price].present?
      min_price = params[:min_price].to_i
      max_price = params[:max_price].to_i
      @games = @games.where(price: min_price..max_price)
    elsif params[:min_price].present?
      min_price = params[:min_price].to_i
      @games = @games.where('price >= ?', min_price)
    elsif params[:max_price].present?
      max_price = params[:max_price].to_i
      @games = @games.where('price <= ?', max_price)
    end
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to games_url, alert: 'Game could not be destroyed because it has dependent records.'
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :description, :price, :image)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
  end
end
