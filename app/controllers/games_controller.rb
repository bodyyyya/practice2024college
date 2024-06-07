class GamesController < ApplicationController
  def index
    if params[:query].present?
      @games = Game.search(params[:query]).records.to_a
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end