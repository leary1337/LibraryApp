# frozen_string_literal: true

# Route 'reader'
class LibraryApp
  hash_branch 'reader' do |r|
    set_view_subdir 'readers'

    r.on Integer do |reader_id|
      @reader = opts[:readers].reader_by_id(reader_id)
      next if @reader.nil?

      @books_of_reader = @reader.borrowed_books

      # /reader/ID
      r.is do
        view('reader')
      end

      # reader/ID/BOOK_ID
      r.on String do |book_id|
        @book = opts[:books].book_by_id(book_id)
        next if @book.nil?

        r.get do
          @parameters = {}
          view('return_book')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(ReturnBookFormSchema.call(r.params))
          if @parameters.success?
            @penalty = @reader.return_book(book_id, @parameters[:return_date])
            @book.book_is_returned
          end
          view('return_book')
        end
      end
    end
  end
end
