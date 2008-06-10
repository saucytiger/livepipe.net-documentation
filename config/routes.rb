require File.join(File.dirname(__FILE__), 'redirection_map')
require File.join(File.dirname(__FILE__), 'spam_urls')
require File.join(File.dirname(__FILE__), 'action_map')

ActionController::Routing::Routes.draw do |map|
  ACTIONS.each do |name,route|
    map.send name.to_sym, route, :controller => 'page', :action => name
  end
  map.extra '/extra/:extra', :controller => 'page', :action => 'extra', :requirements => {:extra => Regexp.new("(#{EXTRAS.join('|')})")}
  map.control '/control/:control', :controller => 'page', :action => 'control', :requirements => {:control => Regexp.new("(#{CONTROLS.join('|')})")}
  REDIRECTION_MAP.each do |old_url,new_url|
    map.connect old_url, :controller => 'redirect', :action => 'redirect', :url => new_url
  end
  SPAM_URLS.each do |spam_url|
    map.connect spam_url, :controller => 'redirect', :action => 'spam', :url => spam_url
  end
  map.catch '*path', :controller => 'redirect', :action => 'catch'
end