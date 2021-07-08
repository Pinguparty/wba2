class Book < ApplicationRecord
    has_and_belongs_to_many :authors
    has_many :book_instances, dependent: :destroy

    before_create :set_pub_year

    validates :title, :publisher, :pub_year, :edition, :isbn, presence: { message: "muss vorhanden sein." }
    validate :isbn_length

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

    def isbn_length
        if !(self.isbn.length == 10 || self.isbn.length == 13)
            errors.add(:isbn, "ISBN muss 10 oder 13 Zeichen lang sein")
        end
    end
end
