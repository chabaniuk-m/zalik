require 'minitest/autorun'
require_relative '../email'

class EmailTest < Minitest::Test
   def setup
      # Do nothing
   end

   def teardown
      # Do nothing
   end

   def test
      @a = Email.new('aaa@gmail.com')
      @b = Email.new('bbb@gmail.com')
      @c = Email.new('ccc@gmail.com')
      self.assert_equal(%w[aaa@gmail.com bbb@gmail.com ccc@gmail.com], @a.all_emails.keys)
   end
end
