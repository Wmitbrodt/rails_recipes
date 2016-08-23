class Ingredient < ApplicationRecord
   belongs_to :recipe, inverse_of: false
end

