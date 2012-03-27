module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def link_twitter_user(txt)
    txt = txt+" "
  	if match = txt.scan(/.*?(@)((?:[a-z0-9\_][a-z0-9\_]+))(:|\s)/i)
  		match.each do |m|
  		  name = m[1]
  		  txt.gsub!(name, '<a href="http://twitter.com/' + name + '">' + name + '</a>')
		  end
  	end
  	txt
  end

end
