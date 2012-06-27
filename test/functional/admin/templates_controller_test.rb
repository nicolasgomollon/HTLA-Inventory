require 'test_helper'

class Admin::TemplatesControllerTest < ActionController::TestCase
  test "templates#new" do
    get :new
    assert_response :success
    #TODO: rubify #new
  end
  
  test "templates#create" do
    get :create, {:name => "HP Mini 2140", :parts => computer_templates(:hp).parts}
    
    assert_equal computer_templates(:hp).parts, assigns(:template).parts
    assert_redirected_to admin_template_path(assigns(:template))
  end
end
