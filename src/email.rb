require_relative 'category'
require_relative 'letter'
require 'date'

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
            if @@all_emails.include? email_address
               raise EmailError("There is already email with address '#{email_address}'")
            else
               @email = email_address
               @categories = {
                  :spam => Category.new('spam'),
                  :inbox => Category.new('inbox'),
                  :sent => Category.new('sent')
               }
               @@all_emails[@email] = self
               @spammers = []
            end
         else
            raise EmailError("Please provide a valid email address")
         end
      else
         raise EmailError("Email address must be of type String")
      end
   end

   def create_category(name)
      @categories[name.to_sym] = Category.new(name)
   end

   def get_categories
      @categories.keys
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

   def send_letter(to, title, body, tags, date=DateTime.now)
      if @@all_emails.keys.include? to
         letter = Letter(@email, to, title, body, tags, date)
         @@all_emails[to].receive_letter(letter)
         @categories[:sent].push(letter)
      end
   end

   def self.get_all_categories
      return @@all_emails.keys
   end

   def self.find_email(email_address)
      if @@all_emails.include? email_address
         @@all_emails[email_address]
      else
         raise EmailError("There is no email with address '#{email_address}'")
      end
   end

   def self.include?(email_address)
      @@all_emails.include? email_address
   end
end
