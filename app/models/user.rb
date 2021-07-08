class User < ApplicationRecord
    has_many :reserved_books, class_name: 'BookInstance', inverse_of: 'reserved_by', foreign_key: 'reserved_by_id'
    has_many :lended_books, class_name: 'BookInstance', inverse_of: 'lended_by', foreign_key: 'lended_by_id'


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

    def fullname
        "#{given_name} #{family_name}"
    end

    def short_name
        "#{given_name[0]}. #{family_name}"
    end

    def has_due_books
        true
    end
end