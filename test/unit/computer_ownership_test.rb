require 'test_helper'

class ComputerOwnershipTest < ActiveSupport::TestCase
  test "John Smith ownership is current" do
    assert computer_ownerships(:bobby_hp).current?
  end
  
  test "Julian Moore ownership is NOT current" do
    assert !computer_ownerships(:julian_acer).current?
  end
end
