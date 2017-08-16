def nav(root_item, buffer='', layer=0)
  return buffer if root_item.nil? || root_item.path.nil? || root_item[:is_hidden]

  children = nav_children(root_item)

  if nav_active?(root_item)
    buffer << "<li class=\"active\">"
  else
    buffer << "<li>"
  end

  title = nav_title_of(root_item)
  if layer == 0
    buffer << "<h2 class=\"nav-header\"><i class=\"fa\"></i><span>#{title}</span></h2>"
  else
    buffer << link_to(title, root_item.path)
  end

  if children.any?
    buffer << %(<ul class="nav #{nav_active?(root_item) ? 'active' : ''}">)

    children.each do |child|
      nav(child, buffer, layer + 1)
    end

    buffer << '</ul>'
  end

  buffer << '</li>'
  buffer
end

def nav_active?(item)
  active = @item_rep.respond_to?(:path) && @item_rep.path == item.path
  active || nav_children(item).any? { |child| nav_active?(child) }
end

def nav_title_of(i)
  i[:nav_title] || i[:title] || ''
end

def nav_children(item)
  children = children_of(item)
    .select { |child| !child[:is_hidden] && child.path }

  if children.all?{ |c| c.key?(:date) }
    children.sort_by{ |c| c[:date] }.reverse
  else
    children.sort_by{ |c| c[:title] || '' }
  end
end
