module ApplicationHelper
  
  def bootstrap_class_for(flash_type)
    case flash_type      
        when 'notice'  then "alert alert-info"
        when 'success' then "alert alert-success"
        when 'error' then "alert alert-danger"
        when 'alert' then "alert alert-warning"
    end
  end

end
