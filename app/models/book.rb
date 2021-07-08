class Book < ApplicationRecord
    has_and_belongs_to_many :authors
    has_many :book_instances, dependent: :destroy

    before_create :set_pub_year

    def self.custom_select(filter)
        books = Book.all
        
        case filter
        when 'no_authors'
            books = books.select { |a| a.authors.empty? }
        when 'no_book_instances'
            books = books.select { |a| a.book_instances.empty? }
        end

        return books
    end

    def set_pub_year
        self.pub_year = Date.current.year
    end
end
