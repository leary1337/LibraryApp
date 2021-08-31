# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'

ListBooksFilterSchema = Dry::Schema.Params do
  optional(:genre).maybe(SchemaTypes::StrippedString, min_size?: 1)
  optional(:author).maybe(SchemaTypes::StrippedString, min_size?: 1)
end
