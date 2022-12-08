# frozen_string_literal: true

require_relative "test_helper"
require_relative '../src/email'

class TestZalik < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Zalik::VERSION
  end

  def before_setup
    super
    unless Email.include? 'ccc@gmail.com'
      a = Email.new('aaa@gmail.com')
      b = Email.new('bbb@gmail.com')
      c = Email.new('ccc@gmail.com')
    end
  end

  def test_it_does_something_useful
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
    begin
      a = Email.find_email('aaa@gmail.com')
      a.create_category(9898)
      assert false, "there must be unavailable to create a category with invalid name"
    rescue
      assert true
    end
  end

  def test_category
    a = Email.find_email('aaa@gmail.com')
    a.create_category('favorite')
    assert_equal([:spam, :inbox, :sent, :favorite], a.get_categories, 'Expected a new category to be added')
  end

  def test_send_and_receive_letter
    a = Email.find_email('aaa@gmail.com')
    b = Email.find_email('bbb@gmail.com')
    if b.is_a? Email and a.is_a? Email
      begin
        b.send_letter('non-existing-email@address', 'Hello', 'Would you receive me?', [:none])
        assert false, "It must be impossible to send email to a non-existing email"
      rescue
        assert true
      end
      dt = DateTime.now
      b.send_letter('aaa@gmail.com', 'Party invitation', "Hi, Arnold!\nHow are you? I'd like to invite you to my birthday party...", [:party, :invitation, :friends], dt)
      assert a.include_in?(:inbox, Letter.new('bbb@gmail.com', 'aaa@gmail.com', 'Party invitation', "Hi, Arnold!\nHow are you? I'd like to invite you to my birthday party...", [:party, :invitation, :friends], dt))
      assert b.include_in?(:sent, Letter.new('bbb@gmail.com', 'aaa@gmail.com', 'Party invitation', "Hi, Arnold!\nHow are you? I'd like to invite you to my birthday party...", [:party, :invitation, :friends], dt))
    end
  end
end
