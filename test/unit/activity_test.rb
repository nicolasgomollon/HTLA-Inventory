require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "default date is today" do
    assert_equal Activity.new.date, Date.today
  end
end
