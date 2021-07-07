require 'date'

class BookInstance < ApplicationRecord
  belongs_to :book
  belongs_to :reserved_by, class_name:"User", inverse_of: 'reserved_books', :optional => true
  belongs_to :lended_by, class_name:"User", inverse_of: 'lended_books', :optional => true

  before_update :before_update

  def before_update
    if self.lended_by != nil
      self.checkout_at = Time.now;
      self.due_at = Time.now + 40.days;
      self.returned_at = nil;
    else
      self.checkout_at = nil
      self.due_at = nil
      self.returned_at = Time.now
    end
  end

  def self.custom_select(filter)
    book_instances = BookInstance.all
    case filter
    when 'lendable'
        book_instances = book_instances.select { |a| !a.reserved_by_id? && !a.lended_by_id? }
    when 'reserved'
      book_instances = book_instances.select { |a| a.reserved_by_id? }
    when 'lended'
      book_instances = book_instances.select { |a| a.lended_by_id? }
    when 'due'
      book_instances = book_instances.select { |a| a.due_at? && a.due_at.past? }
    end
    return book_instances
  end
end
