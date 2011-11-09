module PartialMap
  class PlainFormatter < BaseFormatter
    def partial(file,level)
      level_prefix(level) + clean_path(file) + "\n"
    end

    def link_to_partial(file)
      clean_path(file)
    end

    def level_prefix(level)
      (level>0 ? "|" : "\n") << "---" * level  
    end
    
    def heading(heading)
      "== #{heading} =="
    end

    def list(lst)
      lst.map{|i| clean_path(i)}.join("\n")
    end

  end
end
