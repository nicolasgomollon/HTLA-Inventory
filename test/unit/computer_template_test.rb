require 'test_helper'

class ComputerTemplateTest < ActiveSupport::TestCase
  test "can create from array" do
    template = ComputerTemplate.new
    template.part_array = ["Screen","Hard Drive","Shell","Battery","Hinges","Keyboard"]
    assert_equal template.parts, "Screen,Hard Drive,Shell,Battery,Hinges,Keyboard"
  end
  
  test "can get parts from template" do
    assert_not_nil computer_templates(:acer).part_array
    assert_equal computer_templates(:acer).part_array[0], "Screen"
  end
end
