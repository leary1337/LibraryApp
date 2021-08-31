# frozen_string_literal: true

require 'dry-schema'

require_relative '../schema_types'

ReturnBookFormSchema = Dry::Schema.Params do
  required(:return_date).filled(:date)
end
