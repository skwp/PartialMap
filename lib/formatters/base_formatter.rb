module PartialMap
  class BaseFormatter
    def head;"";end
    def foot;"";end

    # virtual methods, subclasses should implement
    def partial(file,depth); raise NotImplementedError; end
    def heading(heading); raise NotImplementedError; end
    def list(list); raise NotImplementedError; end
    def link_to_partial(file); raise NotImplementedError; end

    def clean_path(path)
      base_path = File.join(::Rails.root.to_s,'app/views/')
      cleaned_path="#{path.gsub(base_path,"")}"
    end

  end
end
