require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "Student.nicename gives nice name" do
    assert_equal students(:julian).nicename, "Julian Moore" 
  end
  
  test "Student associations aren't broken" do
    assert_not_nil students(:julian).computers
    assert_not_nil students(:julian).computer_ownerships
    assert_not_nil students(:julian).bills
  end
end
