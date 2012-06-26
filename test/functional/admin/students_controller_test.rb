require 'test_helper'

class Admin::StudentsControllerTest < ActionController::TestCase
  test "routing" do
    assert_routing "/admin/students", {:controller => "admin/students", :action => "index"} 
  end
  
  test "search" do
    get :index, { :firstname => students(:julian).firstname }
    assert_equal assigns(:students)[0], students(:julian)
    
    get :index, { :firstname => students(:julian).firstname, :id => students(:julian).id }
    assert_equal assigns(:students)[0], students(:julian)
    
    get :index, { :id => students(:julian).id }
    assert_equal assigns(:students)[0], students(:julian)
    
    get :index, { :firstname => students(:bobby).firstname }
    assert_equal assigns(:students)[0], students(:bobby)
  end
  
  test "show" do
    get :show, {:id => students(:julian).id}
    assert_response :success
    assert_equal assigns(:student), students(:julian)
  end
end
