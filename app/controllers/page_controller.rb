class PageController < ApplicationController
  caches_page *((ACTIONS.keys + ['extra','control']) - ['clear_cache']).collect(&:to_sym)
  
  def index
    
  end
  
  def core
    
  end
  
  def controls
    
  end
  
  def control
    return render :text => 'This content is the response from an AJAX call.' if params.has_key? :ajax
  end
  
  def extras
    
  end
  
  def extra
    
  end
  
  def download
    
  end
  
  def clear_cache
    ACTIONS.keys.each do |action|
      expire_page :action => action
    end
    CONTROLS.each do |control|
      expire_page :action => 'control', :control => control 
    end
    EXTRAS.each do |extra|
      expire_page :action => 'extra', :extra => extra
    end
    render :text => 'Cache cleared.'
  end
end