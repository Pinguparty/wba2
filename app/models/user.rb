class User < ApplicationRecord
    has_many :reserved_books, class_name: 'BookInstance', inverse_of: 'reserved_by', foreign_key: 'reserved_by_id'
    has_many :lended_books, class_name: 'BookInstance', inverse_of: 'lended_by', foreign_key: 'lended_by_id'

    validates :family_name, :given_name, :adress, :email, presence: { message: "muss vorhanden sein." }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    before_destroy :before_destroy

    def self.custom_select(filter)
        users = User.all

        case filter
        when 'has_reserved'
            users = users.select { |a| !a.reserved_book_ids.empty? }
        when 'has_lended'
            users = users.select { |a| !a.lended_book_ids.empty? }
        when 'has_due'
            users = users.select { |a| a.has_due_books }
        end

        return users
    end

    def before_destroy
        lendedBooks = BookInstance.select { |a| a.lended_by_id == self.id }
        reservedBooks = BookInstance.select { |a| a.reserved_by_id == self.id}

        puts "foo"
        puts lendedBooks
        puts lendedBooks.empty?

        if lendedBooks.empty?
            reservedBooks.each do |books| 
                books.reserved_by = nil
                books.save
            end
        else
            errors.add(:id, "Nutzer hat noch Bücher ausgeliehen.")
            throw(:abort)
        end
    end

    def full_name
        "#{given_name} #{family_name}"
    end

    def short_name
        "#{given_name[0]}. #{family_name}"
    end

    def has_due_books
        return !self.lended_books.select {|lb| 
            if lb.due_at
                lb.due_at.past?
            end 
        }.empty?
    end
end