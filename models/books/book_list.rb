# frozen_string_literal: true

require 'csv'
require_relative 'book'

# The class that contains all our books
class BookList
  def initialize(books = {})
    @books = books
  end

  def all_books
    @books.values
  end

  def filter(age, genre, author)
    @books.values.select do |book|
      next if age < book.age_rating.gsub('+', '').to_i
      next if !blank?(genre) && !book.genre.include?(genre)
      next if !blank?(author) && !book.author.include?(author)

      true
    end
  end

  def books_by_genre(genre)
    @books.values.select { |book| book.genre == genre }.sort_by { |book| [book.author, book.title] }
  end

  def genres_list
    @books.values.map(&:genre).uniq
  end

  def authors_list
    @books.values.map(&:author).uniq
  end

  def not_uniq_key?(key)
    @books.keys.include?(key)
  end

  def book_by_id(id)
    @books[id]
  end

  def books_by_ids(books_ids_list)
    books_list = []
    books_ids_list.each { |id| books_list.append(@books[id]) if @books.key?(id) }
    books_list
  end

  def delete_book(id)
    @books.delete(id)
  end

  def lose_books(borrowed_books)
    borrowed_books.each_key { |id| @books[id].lose_book if @books.key?(id) }
  end

  def add_book(params)
    book_id = params[:inventory_number]
    @books[book_id] = Book.new(**params.to_h)
    book_id
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, col_sep: ';') do |row|
      book_hash = {
        author: row[0],
        title: row[1],
        inventory_number: row[2],
        genre: row[3],
        age_rating: row[4],
        books_in_stock: row[5],
        books_out_of_stock: row[6]
      }
      add_book(book_hash)
    end
  end

  private

  def blank?(check_str)
    check_str.nil? || check_str.empty?
  end
end
