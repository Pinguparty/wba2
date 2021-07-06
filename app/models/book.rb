class Book < ApplicationRecord
    has_and_belongs_to_many :authors
    has_many :book_instances, dependent: :destroy
end
