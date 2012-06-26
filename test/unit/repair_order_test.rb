require 'test_helper'

class RepairOrderTest < ActiveSupport::TestCase
  test "default startdate is today" do
    assert_equal RepairOrder.new.startdate, Date.today
  end
  
  test "RepairOrder.open creates activity" do
    repair = computers(:acer).repair_orders.new
    repair.open("Broken screen")
    assert_not_empty repair.activities
  end
  
  test "RepairOrder.close creates activity" do
    repair = computers(:acer).repair_orders.new
    repair.open("Broken screen")
    repair.close("Fixed screen")
    assert_equal repair.activities[1].message, Activity::Messages[:closed]
  end
  
  test "RepairOrder.close fails on un-open task" do
    repair = computers(:acer).repair_orders.new
    assert_equal repair.close("Fixed screen"), false
  end
  
  test "RepairOrder.open fails on opened task" do
    repair = computers(:acer).repair_orders.new
    repair.open("Broken screen")
    assert_equal repair.open("Broken screen"), false
  end
  
  test "input startdate is maintained" do
    assert_equal repair_orders(:repair_hp_screen).startdate, RepairOrder.find(repair_orders(:repair_hp_screen).id).startdate 
  end
  
  test "open? works properly" do
    assert repair_orders(:repair_hp_screen).open?
    assert !repair_orders(:repair_hp_keyboard).open?
  end
end