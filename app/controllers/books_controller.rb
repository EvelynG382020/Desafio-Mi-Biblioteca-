class BooksController < ApplicationController
    before_action :set_book, only: [:show, :edit, :update, :destroy]

    def index
        @q = Book.ransack(params[:q])
        @books = @q.result(distinct: true).page(params[:page])
    end

    def show
    end

    def new
        @book = Book.new
    end

    def edit
    end

    def create
        @book = Book.new(book_params)
    
        respond_to do |format|
            if @book.save
                format.html { redirect_to @book, notice: "Book was successfully created." }
                format.json { render :show, status: :created, location: @book }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @book.update(book_params)
                format.html { redirect_to @book, notice: "Book was successfully updated." }
                format.json { render :show, status: :ok, location: @book }
            else
                format.html { render :edit }
                format.json { render json: @book.errors, status: :unprocessable_entity }
            end
        end
      end

    def destroy
        @book.destroy
        respond_to do |format|
          format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
          format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    #strong parameters en donde se mueve toda la lógica para protegerse 
    #de ​ataques de asignación masiva fuera del modelo, dejando esta lógica directamente en el controlador.
    def book_params
      params.require(:book).permit(:title, :author, :status, :given, :returned)
    end
end



















