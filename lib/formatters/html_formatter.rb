module PartialMap
  class HtmlFormatter < BaseFormatter
    def head
      %{
      <html>
      <head>
      <style>
        a { text-decoration: none }
      </style>
      </head>
      <body><ul>
      }
    end

    def partial(file,level)
      %{<li style='margin-left: #{level}em'>#{link_to_partial(file)}</li>}        
    end

    def heading(heading)
      "<h3>#{heading}</h3>"
    end

    def list(list)
      "<ul><li>" + list.map {|entry| link_to_partial(entry)}.join("</li><li>") + "</li></ul>"
    end

    def link_to_partial(file)
      %{ <a href="file://#{file}">#{clean_path(file)}</a> }
    end

    def foot
      %{</ul></body></html>}
    end

  end
end
