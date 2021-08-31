# frozen_string_literal: true

# Route 'give-book'
class LibraryApp
  hash_branch 'give-book' do |r|
    set_view_subdir 'readers'

    r.on Integer, String do |reader_id, book_id|
      @reader = opts[:readers].reader_by_id(reader_id)
      next if @reader.nil?

      r.get do
        @parameters = {}
        view('give_book')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(GiveBookFilterSchema.call(r.params))
        book = opts[:books].book_by_id(book_id)
        next if book.nil?

        @is_available_in_stock = book.available_in_stock?
        if @parameters.success? && @is_available_in_stock
          book.give_book
          @reader.add_book(book_id, @parameters[:return_date])
          r.redirect "/reader/#{reader_id}"
        else
          view('give_book')
        end
      end
    end
  end
end
