def index_from_file(index_name, filepath)
  text=File.open(filepath).read
  text.gsub!(/\r\n?/, "\n")
  li_eles = text.each_line.map do |line|
    name, url = line.split(',')
    "<li><a href=\"#{url}\">#{name}</a></li>"
  end
  "<h2>#{index_name}</h2>\n<ul>\n#{li_eles.join("\n")}\n</ul>"
end
