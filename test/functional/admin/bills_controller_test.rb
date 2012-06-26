require 'test_helper'

class Admin::BillsControllerTest < ActionController::TestCase
  test "new" do
    get :new, {:repair_id => repair_orders(:repair_hp_screen).id}
    assert_response :success
    assert_not_nil assigns(:bill)
    assert_select "form", 1
  end
  
  test "new fails on closed repair order" do
    get :new, {:repair_id => repair_orders(:repair_hp_keyboard).id}
    assert_response :success
    assert_equal assigns(:error), Admin::BillsController::Messages[:repair_closed]
    assert_select "form", 0
  end 
end
