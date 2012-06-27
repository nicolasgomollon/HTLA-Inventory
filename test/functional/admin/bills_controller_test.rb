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
    assert_nil assigns(:bill)
    assert_equal Admin::BillsController::Messages[:repair_closed], assigns(:error)
    assert_select "form", 0
  end
  
  test "create fails on closed repair order" do
    post :create, {
        :repair_id => repair_orders(:repair_hp_keyboard).id,
        :desc => "Broken screen",
        :amount => "125.00"}
    assert_equal Admin::BillsController::Messages[:repair_closed], flash[:error]
    assert_redirected_to edit_admin_repair_order_path(repair_orders(:repair_hp_keyboard).id)
  end 
end
