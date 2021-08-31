# frozen_string_literal: true

# Route 'list-books'
class LibraryApp
  hash_branch 'list-books' do |r|
    set_view_subdir 'readers'

    # /list-books/ID
    r.on Integer do |reader_id|
      @reader = opts[:readers].reader_by_id(reader_id)
      next if @reader.nil?

      @all_genres = opts[:books].genres_list
      @all_authors = opts[:books].authors_list
      @parameters = DryResultFormeWrapper.new(ListBooksFilterSchema.call(r.params))

      @books = opts[:books].filter(@reader.count_age, @parameters[:genre], @parameters[:author]) if @parameters.success?

      r.is do
        view('list_books')
      end
    end
  end
end
