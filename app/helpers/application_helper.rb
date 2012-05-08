module ApplicationHelper
 def title_text(page_title)                           # Method definition
    base_title = "Spoke Geek"
    if !page_title || page_title.empty? || page_title == 'Home'      # Boolean test
      "#{base_title} Bicycle Club"                    # Implicit return
    else
      "#{base_title} | #{page_title}"                 # String interpolation
    end
  end
end