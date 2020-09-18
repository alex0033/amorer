module ApplicationHelper
  def show_as(dropdown_item)
    if dropdown_item
      "dropdown-item"
    end
  end

  def show_messages_count
    if cookies[NUMBER_OF_MESSAGES].to_i > 0
      cookies[NUMBER_OF_MESSAGES]
    end
  end
end
