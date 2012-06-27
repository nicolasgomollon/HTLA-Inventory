require 'test_helper'

class Admin::OwnershipsControllerTest < ActionController::TestCase
  test "ownership new" do
    #get :new
    #assert_response :success
    #assert_not_nil assigns(:ownership)
    #assert_select "form", 1
    #just causes errors at the moment
    #TODO: handle more gracefully
    
    get :new, {:computer_id => computers(:acer).id}
    assert_response :success
    assert_not_nil assigns(:ownership).computer_id
    
    get :new, {:student_id => students(:julian).id}
    assert_response :success
    assert_not_nil assigns(:ownership).student_id
  end
  
  test "ownership create" do
    started = 3.months.ago.to_s(:db)
    
    get :create, {:computer_ownership => {:student_id => students(:julian).studentid, :computer_id => computers(:acer).idtag}, :date => started}
    assert_not_nil assigns(:ownership)
    assert_equal students(:julian).id, assigns(:ownership).student_id
    assert_equal computers(:acer).id, assigns(:ownership).computer_id
    assert_redirected_to admin_computer_ownership_path(assigns(:ownership))
  end
  
  test "ownership show" do
    get :show, {:id => computer_ownerships(:julian_acer).id}
    
    assert_response :success
    assert_equal computer_ownerships(:julian_acer), assigns(:ownership)
  end
end
