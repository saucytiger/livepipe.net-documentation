class RedirectController < ApplicationController
  def redirect
    #if params[:url] && params[:url].match(/http\:\/\//)
    #  render :text => 'The page has moved to: <a href="' + params[:url] + '">' + params[:url] + '</a><script>window.setTimeout(function(){window.location = "' + params[:url] + '"},2000);</script>'
    #else
      redirect_to params[:url], :status => 301
    #end
  end
  
  def catch
    flash[:catch] = true
    redirect_to :controller => 'page', :action => 'index', :status => 404
  end
  
  def spam
    flash[:spam] = true
    redirect_to :controller => 'page', :action => 'index', :status => 404
  end
end