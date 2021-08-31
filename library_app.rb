# frozen_string_literal: true

require 'roda'
require 'forme'
require_relative 'models'

# The core class of application
class LibraryApp < Roda
  BOOKS_DATA_FILE = File.expand_path('data/books.csv', __dir__)
  READERS_DATA_FILE = File.expand_path('data/readers.csv', __dir__)

  opts[:root] = __dir__
  plugin :environments
  plugin :render, layout: './layout'
  plugin :forme
  plugin :hash_routes
  plugin :view_options
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:books] = BookList.new
  opts[:books].read_in_csv_data(BOOKS_DATA_FILE)

  opts[:readers] = ReaderList.new
  opts[:readers].read_in_csv_data(READERS_DATA_FILE)

  Dir['routes/*.rb'].each { |f| require_relative f }

  status_handler(404) do
    view('./not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.hash_branches

    r.root do
      view('index')
    end
  end
end
