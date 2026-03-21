class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
    authorize @movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to @movie, notice: "Film ajouté !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @movie
  end

  def update
    authorize @movie
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Film modifié !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @movie
    @movie.destroy
    redirect_to movies_path, notice: "Film supprimé !"
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :genre, :description, :jacket)
  end
end
