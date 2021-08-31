# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'

ReaderFormSchema = Dry::Schema.Params do
  required(:full_name).filled(SchemaTypes::StrippedString)
  required(:date_of_birth).filled(:date)
end
