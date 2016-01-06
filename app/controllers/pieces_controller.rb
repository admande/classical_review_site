class PiecesController < ApplicationController
  def new
    @piece = Piece.new
  end

  def index
    @pieces = Piece.page(params[:page]).per(10)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.new(piece_params)
    if @piece.update_attributes(piece_params)
      flash[:notice] = "Piece edited successfully"
      redirect_to @piece
    else
      flash[:errors] = @piece.errors.full_messages.join(". ")
      render :edit
    end
  end

  def create
    @piece = Piece.new(piece_params)
    if @piece.save
      flash[:notice] = "Piece added successfully"
      redirect_to new_piece_path
    else
      flash[:errors] = @piece.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    Piece.find(params[:id]).destroy
    flash[:success] = "Piece Deleted"
    redirect_to root_path
  end

  private

  def piece_params
    params.require(:piece).permit(:title, :composer)
  end
end
