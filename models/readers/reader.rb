# frozen_string_literal: true

# The information about the reader
class Reader
  attr_reader :id, :full_name, :date_of_birth

  def initialize(id, params)
    @id = id
    @full_name = params[:full_name]
    @date_of_birth = params[:date_of_birth].is_a?(String) ? Date.parse(params[:date_of_birth]) : params[:date_of_birth]
    @list_books = params[:list_books]
  end

  def count_age
    now = Time.now.to_date
    is_inc = now.month > @date_of_birth.month || (now.month == @date_of_birth.month && now.day >= @date_of_birth.day)
    now.year - @date_of_birth.year - (is_inc ? 0 : 1)
  end

  def borrowed_books
    @list_books.dup
  end

  def overdue_borrowed_books(need_date)
    @list_books.select { |_, date| date < need_date }.keys
  end

  def delete_book(book_id)
    @list_books.delete(book_id)
  end

  def return_book(book_id, return_date)
    days_ago = (return_date - @list_books[book_id]).to_i
    delete_book(book_id)
    days_ago.positive? ? days_ago : 0
  end

  def add_book(book_id, return_date)
    @list_books[book_id] = return_date
  end
end
