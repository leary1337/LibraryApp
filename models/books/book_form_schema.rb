# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'
require_relative 'book_age_rating_type'

BookFormSchema = Dry::Schema.Params do
  required(:title).filled(SchemaTypes::StrippedString)
  required(:author).filled(SchemaTypes::StrippedString)
  required(:inventory_number).filter(format?: /\d{3}-\d+-\d{7}-\d+-\d+/)
  required(:genre).filled(SchemaTypes::StrippedString)
  required(:age_rating).filled(SchemaTypes::StrippedString, included_in?: BookAgeRatingType.all_types)
  required(:books_in_stock).filled(:integer, gt?: 0)
  required(:books_out_of_stock).filled(:integer, gt?: 0)
end
