# frozen_string_literal: true

require 'csv'
require_relative 'reader'

# The class that contains all our books
class ReaderList
  def initialize(readers = {})
    @readers = readers
  end

  def all_readers
    @readers.values
  end

  def all_overdue_borrowed_books(need_date)
    @readers.values.flat_map { |reader| reader.overdue_borrowed_books(need_date) }.uniq
  end

  def reader_by_id(id)
    @readers[id]
  end

  def delete_reader(id)
    @readers.delete(id)
  end

  def delete_book_from_readers(book_id)
    @readers.each_value { |reader| reader.delete_book(book_id) }
  end

  def add_reader(params)
    reader_id = if @readers.empty?
                  1
                else
                  @readers.keys.max + 1
                end
    @readers[reader_id] = Reader.new(reader_id, **params.to_h)
    reader_id
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, col_sep: ';') do |row|
      reader_hash = {
        full_name: row[0],
        date_of_birth: row[1],
        list_books: prepare_list_books(row[2])
      }
      add_reader(reader_hash)
    end
  end

  private

  def prepare_list_books(books_string)
    return {} unless books_string

    books_string.split(', ').reduce({}) do |new_hash, book|
      book_data = book.split(' - ')
      new_hash.update({ book_data[0] => Date.parse(book_data[1]) })
    end
  end
end
