class EvaluationType < ApplicationRecord
  has_many :evaluations
  has_many :posts
end
