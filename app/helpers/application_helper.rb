# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def api_table(name = false,*labels,&block)
    table = ItemTable.new
    yield table
    concat(subhead(name),block.binding) if name
    concat(render(:partial => 'components/api_table', :locals => {:items => table.items,:labels => labels}),block.binding)
  end
  
  def options_table(name = false,*labels,&block)
    table = ItemTable.new
    yield table
    concat(subhead(name),block.binding) if name
    concat(render(:partial => 'components/options_table', :locals => {:items => table.items,:labels => labels}),block.binding)
  end
  
  def events_table(name = false,*labels,&block)
    table = ItemTable.new
    yield table
    concat(subhead(name),block.binding) if name
    concat(render(:partial => 'components/events_table', :locals => {:items => table.items,:labels => labels}),block.binding)
  end
  
  def examples_table(name = false,*labels,&block)
    table = ItemTable.new(false)
    yield table
    concat(subhead(name),block.binding) if name
    concat(render(:partial => 'components/examples_table', :locals => {:items => table.items,:labels => labels}),block.binding)
  end
  
  class ItemTable	  
	  def initialize(sort = true)
	    @sort = sort
	    @items = []
	  end
	  
	  def item(item)
	    @items.push(item)
	  end
	  
	  def items
	    return @items if !@sort
	    @items.sort_by do |item|
	      if item[:signature]
	        if item[:signature].match(/^\s?(initialize|load)\(/)
	          "1"
	        elsif !item[:signature].match(/^\s?[\w\_]+\s?\(/)
	          "zzz" + item[:signature]
	        else
	          item[:signature]
	        end
	      elsif item[:name]
	        item[:name]
	      else
	        ""
	      end
	    end
	  end
	end
	
	def javascript(name = false,&block)
	  concat(subhead(name),block.binding) if name
	  concat('<pre class="highlighted"><code class="javascript">',block.binding)
    yield
	  concat('</code></pre>',block.binding)
	end
	
	def html(name = false,&block)
	  concat(subhead(name),block.binding) if name
	  concat('<pre class="highlighted"><code class="xml">',block.binding)
    yield
	  concat('</code></pre>',block.binding)
	end
	
	def css(name = false,&block)
	  concat(subhead(name),block.binding) if name
	  concat('<pre class="highlighted"><code class="css">',block.binding)
    yield
	  concat('</code></pre>',block.binding)
	end
	
	def header(name = '',&block)
	  if block_given?	  
  	  concat('<h1>',block.binding)
  	  yield
  	  concat('</h1>',block.binding)
	  else
	    "<h1>#{name}</h1>"
	  end
	end
	
	def subhead(name = '',options = {},&block)
	  if block_given?
  	  concat('<h3' + (options[:border] === false ? ' class="borderless"' : '') + '>',block.binding)
  	  yield
  	  concat('</h3>',block.binding)
    else
      "<h3" + (options[:border] === false ? ' class="borderless"' : '') + ">#{name}</h3>"
    end
	end
	
	def introduction(introduction = '',&block)
	  if block_given?
  	  concat('<p class="introduction">',block.binding)
  	  yield
  	  concat('</p>',block.binding)
	  else
	    "<p class=\"introduction\">#{introduction}</p>"
	  end
	end
	
	def paragraph(name = false,&block)
	  concat(subhead(name),block.binding) if name
	  concat('<p>',block.binding)
	  yield
	  concat('</p>',block.binding)
  end
  
  def section(id,&block)
	  concat("<div id=\"#{id}\">",block.binding)
	  yield
	  concat('</div>',block.binding)
  end
  
  def tabs(id,&block)
    tabs = Tabs.new(id)
    yield tabs
    concat(render(:partial => 'components/tabs',:locals => {:tabs => tabs}),block.binding)
  end
  
  class Tabs
    attr_reader :tabs, :id, :source
    
    def initialize(id)
      @id = id
      @tabs = []
      @source = nil
    end
    
    def tab(id,label)
      @tabs.push({
        :id => id,
        :label => label
      })
    end
    
    def source(url = false)
      return @source if !url
      @source = url
    end
  end

  [
    "contextmenu",
    "pagination",
    "progressbar",
    "rating",
    "scrollbar",
    "selection",
    "selectmultiple",
    "tabs",
    "textarea",
    "window"
  ].each do |control|
    eval "def control_#{control}_url; control_url :control => '#{control}' end"
  end
end