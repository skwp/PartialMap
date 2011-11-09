require 'pathname' 
Dir["#{File.dirname(__FILE__)}/formatters/**"].each {|f| require f; puts f}

# Parse a directory looking for top level files, then recurse
# down and expand all their partials. This is pretty inefficient
# as it does a depth first search, opening file descriptors at
# every level, that are only closed once the recursion ends.
# Oh well.
#
# TODO: 
#  * make it more efficient by logging entries in a table and then revisiting them.
#  * handle calls from the view to helpers that render partials (advanced)
#
class String; def titleize; self[0,1].upcase + self[1,self.size].downcase; end; end; #:nodoc:
  
module PartialMap 

  class RailsViewTree
    attr_reader :all_partials

    def initialize(root_path, callback)
      @all_partials = Dir[File.join(RAILS_ROOT,'app','views','**','**')].select {|file| is_partial?(file)}
      @callback = callback
      find_views(root_path)
    end

    def find_views(current, level=0)
      if File.directory?(current)
        Dir.glob("#{current}/*").each do |entry|
          find_views(entry, level)
        end
      elsif !is_partial?(current)
        @callback.list_subpartials(current, level)
      end
    end

    def is_partial?(path)
      path =~ /\/_.*$/
    end
  end

  class Parser

    def initialize(formatter)
      @formatter = formatter
    end
    
    def draw_partial_map(starting_path)
      puts @formatter.head
      @tree = RailsViewTree.new(starting_path, self)
      puts @formatter.foot
    end

    def list_subpartials(file, level=0) 
      # Find the partial matching the name we're looking for
      # since it may end in .rhtml, .html.erb, etc
      output_heading = @formatter.partial(file, level)      
      output=""

      subpartials_found=0
      
      tracked_partials={}

      File.open(file).each do |line|
        if line =~ /render\s+:partial\s+=>\s+['"]([\w\d\/]+)/
          # if partial has a slash, we want to underscore the last part of it
          # 
          partial_reference = $1
          # debug "Parsed partial path #{partial_reference}"

          partial_name = partial_path = ""

          if partial_reference.include?("/")
            components = partial_reference.split('/')
            partial_name, partial_path = components.pop, components.join('/')
            # debug "Path includes a slash so we're going to look at the relative path #{partial_path} name #{partial_name}"
            partial_path = File.join(RAILS_ROOT, "app/views", partial_path, "_#{partial_name}")
          else
            partial_path = File.join(File.dirname(file), "_#{partial_reference}")
          end

          # debug "Searching #{partial_path}"
          partial_filename = Dir[partial_path + "*"].first # find the actual fileame

          unless tracked_partials[partial_filename]
            subpartials_found += 1
            output << list_subpartials(partial_filename,level+1)  
            tracked_partials[partial_filename] = true
          end
        end
      end

      if subpartials_found > 0
        puts output_heading
        puts output
      end

      return output_heading
    end  
  
  end # class
end # module
