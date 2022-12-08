require_relative 'category'

class EmailError < StandardError
   def initialize(msg = "Error working with emails")
      super
   end
end

class Email

   @@all_emails = {}

   attr_reader :all_emails

   def initialize(email_address)
      if email_address.is_a? String
         if email_address.include? "@"
            @email = email_address
            @categories = {
               :spam => Category.new('spam'),
               :inbox => Category.new('inbox'),
               :sent => Category.new('sent')
            }
            @@all_emails[@email] = self
            @spammers = []
         else
            raise EmailError("Please provide a valid email address")
         end
      else
         raise EmailError("Email address must be of type String")
      end
   end

   def add_category(name)
      @categories[name.to_sym] = Category.new(name)
   end

   def move_to_users_category(letter, category_name)
      if category_name.is_a? Symbol
         if letter.is_a? Letter
            if category_name != :sent and category_name != :inbox and @categories.has_key? category_name
               @categories[category_name].push(letter)
            else
               raise EmailError("there is no category with name #{category_name}")
            end
         else
            raise EmailError("letter must be of type Letter")
         end
      else
         raise EmailError("Category name must be a Symbol")
      end
   end

   def receive_letter(letter)
      if letter.is_a? Letter
         if @spammers.include? letter.from
            @categories[:spam].push(letter)
         else
            @categories[:inbox].push(letter)
         end
      end
   end

   def self.get_all_categories
      return @@all_emails.keys
   end
end
