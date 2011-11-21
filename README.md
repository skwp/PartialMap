PartialMap
==========

Too many partials in your project? Can't figure out if the hip bone
connects to the thighbone or the cheekbone? Let PartialMap help :)

    script/rails plugin install git@github.com:skwp/PartialMap.git

Usage
=======

    rake partialmap:text
    rake partialmap:html > ~/partials.html | open ~/partials.html

Example Output:
=======

Here's what a very small partial tree might look like. This was
obtained by running `rake partialmap:text`

    foo/show.html.erb
    |---foo/_foo_name_header.html.erb
    |---foo/_bar_quux_list.html.erb
    |------foo/_quux_group.rhtml
    |---foo/_bazs.rhtml
    |------foo/_baz_line.rhtml
    |---------------foobars/_select_foobar.rhtml
    |------------------foobars/_foobar_subpartial.rhtml

Contributing
=======

Please feel free to fork and contribute to the project. The mapping
algorithm could be improved, the formatters can be made prettier
and more useful. Enjoy!

Not tested with haml, but should theoretically work.

Copyright (c) 2011 Yan Pritzker, yanpritzker.com, released under the MIT license
