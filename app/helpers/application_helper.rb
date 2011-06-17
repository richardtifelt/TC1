module ApplicationHelper
  def jokes_class_name str
    class_name = "jokes"
    if  str.length < 150
      class_name = "jokes-short"
    end
    return class_name
  end
end
