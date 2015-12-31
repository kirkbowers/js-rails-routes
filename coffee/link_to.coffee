# At the risk of polluting the global namespace, add the rails style "link_to" function
link_to = (label, link, opts = {}) ->
  result = '<a href="' + link + '"'
  if opts.id?
    result += ' id="' + opts.id + '"'
  if opts.class?
    result += ' class="' + opts.class + '"'
  if opts.method?
    result += ' rel="nofollow" data-method="' + opts.method + '"'
  if opts.data?
    for key, value of opts.data  
      result += ' data-' + key + '="' + value + '"'
  
  result += '>' + label + '</a>'
  
  result
