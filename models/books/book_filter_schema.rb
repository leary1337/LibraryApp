# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'

BookFilterSchema = Dry::Schema.Params do
  optional(:genre).maybe(SchemaTypes::StrippedString)
  optional(:date).maybe(:date)
end
