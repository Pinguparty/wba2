require 'date'

class BookInstance < ApplicationRecord
  belongs_to :book
  belongs_to :reserved_by, class_name:"User", :optional => true
  belongs_to :lended_by, class_name:"User", :optional => true

  before_update :before_update

  before_create do
    self.purchased_at = Date.today
  end

  def before_update
    puts self
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
end
