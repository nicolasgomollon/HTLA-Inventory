module ApplicationHelper
  def goodbad(tf)
    if tf
      "class='good'"
    else
      "class='bad'"
    end
  end
  
  def showbad(tf)
    "class='bad'" unless tf
  end
end
