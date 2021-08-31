# frozen_string_literal: true

# Route 'readers'
class LibraryApp
  hash_branch 'readers' do |r|
    set_view_subdir 'readers'

    # readers
    r.is do
      @readers = opts[:readers].all_readers
      view('readers')
    end

    # /readers/new
    r.on 'new' do
      r.get do
        @parameters = {}
        view('reader_new')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(ReaderFormSchema.call(r.params))
        if @parameters.success?
          reader_id = opts[:readers].add_reader(@parameters)
          r.redirect "/reader/#{reader_id}"
        else
          view('reader_new')
        end
      end
    end
  end
end
