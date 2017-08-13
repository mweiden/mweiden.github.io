def index_by_category(category)
  #h = {
  #  0 => "One",
  #  1 => "Two",
  #  2 => "Three",
  #  3 => "Four",
  #  4 => "Five",
  #  5 => "Six",
  #  6 => "Seven",
  #  7 => "Eight",
  #  8 => "Nine"
  #}
  #[
  #  "<div class=\"card\">",
  #  "  <div class=\"card-header\" role=\"tab\" id=\"heading#{h[ind]}\">",
  #  "    <h2 class=\"mb-0\">",
  #  "      <a data-toggle=\"collapse\"",
  #  "         href=\"#collapse#{h[ind]}\"",
  #  "         aria-expanded=\"#{ind == 0 ? 'true' : 'false'}\"",
  #  "         aria-controls=\"collapse#{h[ind]}\">",
  #  "        #{category}",
  #  "      </a>",
  #  "    </h2>",
  #  "  </div>",
  #  list_pages_by_category(category,h[ind]),
  #  "</div>"
  #].join("\n")
  [
    "<h2>#{category}</h2>",
    list_pages_by_category(category),
  ].join("\n")
end
