class Rate < ActiveRecord::Base
  belongs_to :post

  validates :value, presence: true,
                    inclusion: { in: 1..5,
                                message: "%{value} is not a valid rate" }
  validates :post, presence: true
end