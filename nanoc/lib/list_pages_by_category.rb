def list_pages_by_category(category)
  list_eles = @items
    .select{ |i| i[:category] == category }
    .map{ |i|
      title = i[:category] == 'blog' ? "#{i[:date]}: #{i[:title]}" : i[:title]
      {
        item: i,
        title: title,
        li_ele: "<li><a href=\"/#{i.raw_filename.split('/')[-1].split('.')[-2]}/\">#{title}</a></li>"
      }
    }.sort_by{ |d| d[:title] }

  if category == 'blog'
      list_eles.reverse!
  end
  #[
  #  "  <div id=\"collapse#{ind}\"",
  #  "       class=\"collapse show\"",
  #  "       role=\"tabpanel\"",
  #  "       aria-labelledby=\"heading#{ind}\"",
  #  "       data-parent=\"#accordion\">",
  #  "    <div class=\"card-body\">",
  #  "      <ul>#{list_eles.map{ |d| d[:li_ele] }.join("\n")}</ul>",
  #  "    </div>",
  #  "  </div>"
  #].join("\n")
  "<ul>#{list_eles.map{ |d| d[:li_ele] }.join("\n")}</ul>"
end
