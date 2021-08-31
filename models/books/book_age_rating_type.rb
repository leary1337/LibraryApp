# frozen_string_literal: true

# The list of possible book age ratings
module BookAgeRatingType
  RATING_OVER_6 = '6+'
  RATING_OVER_12 = '12+'
  RATING_OVER_14 = '14+'
  RATING_OVER_16 = '16+'
  RATING_OVER_18 = '18+'

  def self.all_types
    [
      RATING_OVER_6, RATING_OVER_12, RATING_OVER_14,
      RATING_OVER_16, RATING_OVER_18
    ]
  end
end
