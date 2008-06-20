class RedirectController < ApplicationController
  def redirect
    redirect_to params[:url], :status => 301
  end
  
  def catch
    flash[:catch] = true
    redirect_to :controller => 'page', :action => 'index'
  end
  
  def spam
    flash[:spam] = true
    redirect_to :controller => 'page', :action => 'index'
  end
end