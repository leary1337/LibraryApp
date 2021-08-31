# frozen_string_literal: true

# Route 'create-book'
class LibraryApp
  hash_branch 'create-book' do |r|
    set_view_subdir 'books'

    # /create-book
    r.is do
      r.get do
        @parameters = {}
        view('book_new')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(BookFormSchema.call(r.params))
        @is_not_uniq_key = opts[:books].not_uniq_key?(@parameters[:inventory_number])
        if @parameters.success? && !@is_not_uniq_key
          book_id = opts[:books].add_book(@parameters)
          r.redirect "/book/#{book_id}"
        else
          view('book_new')
        end
      end
    end
  end
end
