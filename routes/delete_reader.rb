# frozen_string_literal: true

# Route 'delete-reader'
class LibraryApp
  hash_branch 'delete-reader' do |r|
    set_view_subdir 'readers'

    r.is do
      reader_id = r.params['reader_id'].to_i
      @reader = opts[:readers].reader_by_id(reader_id)
      next if @reader.nil?

      @books_of_reader = @reader.borrowed_books

      r.get do
        @parameters = {}
        view('reader_delete')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
        if @parameters.success?
          opts[:books].lose_books(@books_of_reader)
          opts[:readers].delete_reader(reader_id)
          r.redirect('/readers')
        else
          view('reader_delete')
        end
      end
    end
  end
end
