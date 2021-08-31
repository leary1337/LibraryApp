# frozen_string_literal: true

# Route 'books'
class LibraryApp
  hash_branch 'books' do |r|
    set_view_subdir 'books'

    # /books
    r.is do
      @parameters = DryResultFormeWrapper.new(BookFilterSchema.call(r.params))
      @books = if @parameters.success? && @parameters[:genre]
                 opts[:books].books_by_genre(@parameters[:genre])
               elsif @parameters.success? && @parameters[:date]
                 books_ids_list = opts[:readers].all_overdue_borrowed_books(@parameters[:date])
                 opts[:books].books_by_ids(books_ids_list)
               else
                 opts[:books].all_books
               end
      view('books')
    end
  end
end
