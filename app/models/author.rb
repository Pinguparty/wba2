class Author < ApplicationRecord
    has_and_belongs_to_many :books

    def self.custom_select(filter)
        authors = Author.all
        case filter
        when 'no_books'
            authors = authors.select { |a| a.books.empty? }
        end
        return authors
    end
end
