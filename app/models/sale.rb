class Sale < ApplicationRecord
  belongs_to :product
  # has_and_belongs_to_many :product_rates

end
