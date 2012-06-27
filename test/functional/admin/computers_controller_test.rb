require 'test_helper'

class Admin::ComputersControllerTest < ActionController::TestCase
  test "computer search" do
    get :index, {:serial => computers(:acer).serial}
    assert_response :success
    assert_equal assigns(:computers)[0], computers(:acer), "Did not find ACERL16 by serial search!"
    
    get :index, {:serial => computers(:acer).serial, :idtag => computers(:acer).idtag}
    assert_equal assigns(:computers)[0], computers(:acer), "Did not find ACERL16 by serial+idtag search!"
    
    get :index, {:serial => computers(:acer).serial}
    assert_equal assigns(:computers)[0], computers(:acer), "Did not find ACERL16 by idtag search!"
  end
  
  test "computer show" do
    get :show, {:id => computers(:acer)}
    assert_response :success
    assert_equal assigns(:computer), computers(:acer)
  end
  
  test "computer new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:computer)
    assert_not_empty assigns(:template_select)
    assert assigns(:template_select).include?([computer_templates(:hp).name, computer_templates(:hp).id])
  end
  
  test "computer create" do
    get :create, {:template_id => computer_templates(:acer),
                  :serial => "LUSAL0B137011506DB1601",
                  :idtag => "ACERL01"} 
                  
    assert_response 302
    assert_equal assigns(:template), computer_templates(:acer)
    assert_not_empty assigns(:computer).parts
    assert_not_nil assigns(:computer).parts['Screen']
    assert_redirected_to edit_admin_computer_path(assigns(:computer))
  end
end
