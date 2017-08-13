def title
  if @item[:display_title] == false
    nil
  else
    "<h1>#{@item[:category] == 'blog' ? "#{@item[:date]}: #{@item[:title]}" : @item[:title]}</h1>"
  end
end
