require 'test_helper'

class ComputerTest < ActiveSupport::TestCase
  test "current student for HPL01 should be bobby" do
    assert_equal computers(:hp).get_current_student.id, students(:bobby).id
  end
  
  test "can get parts for ACERL16" do
    assert_not_empty computers(:acer).parts
  end
  
  test "can create and get parts for HPL01" do
    computers(:hp).create_parts(computer_templates(:hp))
    assert_not_empty computers(:hp).parts
    assert_not_nil computers(:hp).parts['Screen']
  end
  
  test "can get specific parts for ACERL16" do
    assert_not_nil computers(:acer).parts['Screen']
  end
end
