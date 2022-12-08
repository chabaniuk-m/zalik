# frozen_string_literal: true

require_relative "test_helper"
require_relative '../src/email'

class TestZalik < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Zalik::VERSION
  end

  def test_it_does_something_useful
    a = Email.new('aaa@gmail.com')
    b = Email.new('bbb@gmail.com')
    c = Email.new('ccc@gmail.com')
    self.assert_equal(%w[aaa@gmail.com bbb@gmail.com ccc@gmail.com], Email.get_all_categories)
  end

  def test_raising_exeptions
    begin
      a = Email.new(899)
      assert false, "Email's constructor must raise an error on bad type of input arguments"
    rescue
      assert true
    end
    begin
      a = Email.new("mike.jonson")
      assert false, "Email's constructor must raise an error on bad type of input arguments"
    rescue
      assert true
    end
  end
end
