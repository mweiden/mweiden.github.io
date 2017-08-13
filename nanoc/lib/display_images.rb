def display_images(image_names)
  image_names.map{ |filename|
    "<img src=\"../img/#{filename}\" width=\"100%\">"
  }.join("\n")
end
