require_relative 'letter'

class Category

   def initialize(name)
      if name.is_a? String
         @name = name
         @letters = []
      else
         raise TypeError("Expect a name of category to be of type String")
      end

   end

   def push(letter)
      if letter.is_a? Letter
         @letters.push(letter)
      else
         raise TypeError("Only letters can be added to a category")
      end
   end

   def include?(letter)
      @letters.include? letter
   end
end
