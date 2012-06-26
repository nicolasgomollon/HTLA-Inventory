require 'test_helper'

class ComputerPartTest < ActiveSupport::TestCase
  test "ComputerPart.status defaults to true" do
    assert computer_parts(:acer_screen).status
  end
  
  test "ComputerPart.status can be overriden" do
    computer_parts(:acer_screen).status = false
    computer_parts(:acer_screen).save
    assert_equal ComputerPart.find(computer_parts(:acer_screen).id).status, false
  end
end
