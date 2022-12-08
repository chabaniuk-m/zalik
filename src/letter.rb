require 'date'

class Letter

   attr_reader :from, :to, :title, :body, :date
   attr_accessor :category

   def initialize(from, to, title, body, tags, date=DateTime.now)
      @from = from
      @to = to
      @title = title
      @body = body
      @tags = tags
      @date = date
      @category = nil
   end
end
