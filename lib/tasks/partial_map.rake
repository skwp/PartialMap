require File.join(File.dirname(__FILE__),'../partial_map')
namespace(:partialmap) do

  desc "Show a tree of all the view partials."
  task(:text) do
    PartialMap::Parser.new(PartialMap::PlainFormatter.new).draw_partial_map(File.join(RAILS_ROOT,'app/views'))
  end

  desc "Show a tree of all the view partials."
  task(:html) do
    PartialMap::Parser.new(PartialMap::HtmlFormatter.new).draw_partial_map(File.join(RAILS_ROOT,'app/views'))
  end
end
