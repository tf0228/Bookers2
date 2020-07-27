class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), flash: {notice: "You have creatad book successfully." }
    else
      redirect_to books_path, flash: { error: @book.errors.full_messages }
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
    @user = User.find(@book_detail.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book), flash: { notice: "You have updated book successfully." }
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def correct_user
      @book = Book.find(params[:id])
      @user = @book.user
      redirect_to books_path unless @user == current_user 
    end

end
