# frozen_string_literal: true

# Route 'books'
class LibraryApp
  hash_branch 'book' do |r|
    set_view_subdir 'books'

    r.on String do |book_id|
      @book = opts[:books].book_by_id(book_id)
      next if @book.nil?

      # /book/ID
      r.is do
        view('book')
      end

      # /book/ID/delete
      r.on 'delete' do
        r.get do
          @parameters = {}
          view('book_delete')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
          if @parameters.success?
            opts[:books].delete_book(@book.inventory_number)
            opts[:readers].delete_book_from_readers(@book.inventory_number)
            r.redirect('/books')
          else
            view('book_delete')
          end
        end
      end
    end
  end
end
