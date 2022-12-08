require 'date'

class Letter

   attr_reader :from, :to, :title, :body, :date

   def initialize(from, to, title, body, tags, date=DateTime.now)
      @from = from
      @to = to
      @title = title
      @body = body
      @tags = tags
      @date = date
   end

   def ==(other)
      if other == nil
         false
      elsif other.is_a? Letter
         other.date == self.date and other.from == self.from and other.to == self.to and other.title == self.title and other.body == self.body
      else
         false
      end
   end
end
