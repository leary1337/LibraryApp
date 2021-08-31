# frozen_string_literal: true

# The information about the book
class Book
  attr_reader :author, :title, :inventory_number, :genre, :age_rating, :books_in_stock, :books_out_of_stock

  def initialize(params)
    @author = params[:author]
    @title = params[:title]
    @inventory_number = params[:inventory_number]
    @genre = params[:genre]
    @age_rating = params[:age_rating]
    @books_in_stock = params[:books_in_stock].to_i
    @books_out_of_stock = params[:books_out_of_stock].to_i
  end

  def give_book
    @books_in_stock -= 1
    @books_out_of_stock += 1
  end

  def available_in_stock?
    @books_in_stock.positive?
  end

  def lose_book
    @books_out_of_stock.positive? ? @books_out_of_stock -= 1 : @books_out_of_stock = 0
  end

  def book_is_returned
    @books_in_stock += 1
    lose_book
  end
end
