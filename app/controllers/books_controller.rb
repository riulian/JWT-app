class BooksController < ApplicationController
  before_action :authorize
  before_action :set_book, only: %i[ show update destroy ]

  # GET /books
  def index
    #@books = Book.all
    @books = @user.books.all #afiseaza cartile pt acest user specific modificare 1
    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    #@book = Book.new(book_params)
    @book = Book.new(book_params.merge(user: @user)) # adauga cartea impreuna cu userul current     modificare 2
    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      #@book = Book.find(params[:id])
      @book = @user.books.find(params[:id]) #modificare 4 ultima
    end

    # Only allow a list of trusted parameters through.
    def book_params
      #params.require(:book).permit(:title, :user_id)
      params.require(:book).permit(:title)  #modificare 3
    end
end
