require 'test_helper'

class Admin::RepairsControllerTest < ActionController::TestCase
  test "Repairs.index" do
    get :index
    
    assert_response :success
    assert_not_empty assigns(:repairs)
    assert_equal false, assigns(:closed)
    open = assigns(:repairs)
    
    get :index, {:closed => "true"}
    assert_response :success
    assert_not_empty assigns(:repairs)
    assert_not_equal open, assigns(:repairs)
    assert_equal true, assigns(:closed)
  end
  
  test "Repairs.new" do
    get :new
    
    assert_response :success
    assert_not_nil assigns(:repair)
    
    get :new, {:computer_id => computers(:acer).id}
    
    assert_response :success
    assert_not_nil assigns(:repair)
    assert_equal computers(:acer).idtag, assigns(:tag)
  end
  
  test "Repairs.create" do
    post :create, { :computer_tag => computers(:acer).idtag,
                    :date => Date.today.to_s,
                    :desc => "Broken screen"}
                    
    assert_redirected_to admin_repair_order_path(assigns(:repair))
    assert_not_nil assigns(:repair)
    assert_not_empty assigns(:repair).activities
    assert_equal Activity::Messages[:created], assigns(:repair).activities.first.message
  end
  
  test "Repairs.show" do
    get :show, {:id => repair_orders(:repair_hp_screen)}
    
    assert_response :success
    assert_equal repair_orders(:repair_hp_screen), assigns(:repair)
    #Test logic of show page?
  end
  
  test "Repairs.edit" do
    get :edit, {:id => repair_orders(:repair_hp_screen)}
    
    assert_response :success
    assert_equal repair_orders(:repair_hp_screen), assigns(:repair)
    #TODO: add test + logic for failure on edit of closed repair
  end
  
  test "Repairs.update" do
    post :update, {:id => repair_orders(:repair_hp_screen),
                   :desc => "Salvaged screen"}
                   
    assert_redirected_to admin_repair_order_path(repair_orders(:repair_hp_screen))
    
    db_repair = RepairOrder.find(repair_orders(:repair_hp_screen).id)
    assert_equal "Salvaged screen", db_repair.activities.last.desc
    #TODO add test for closing repair orders that won't break other tests
  end
end
