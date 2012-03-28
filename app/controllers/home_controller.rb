# Copyright (c) 2011, Ian Li (http://ianli.com)
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

class HomeController < ApplicationController
  
  before_filter :auth_required, :only => [:logout, :admin]
  
  def index
    @people = Person.find :all
    
    @posts_limit = 3
    @posts = Post.find :all, :order => "published_on DESC", :limit => @posts_limit
    @posts_count = Post.count
    
    @publications_limit = 3
    @publications = Publication.find :all, :order => "year DESC, title ASC", :limit => @publications_limit
    @publications_count = Publication.count
  end
  
  def login
    if session[:return_to].nil?
      session[:return_to] = request.referer
    end
  end
  
  def authenticate
    if params[:password] == ENV['SIMPLE_AUTH_PASSWORD']
      session[:authorized] = true
      flash[:notice] = "You're logged in!"
      redirect_to (session[:return_to] ? session[:return_to] : root_path)
      session[:return_to] = nil
    else
      flash[:notice] = "Incorrect password."
      redirect_to login_path
    end
  end
  
  def logout
    flash[:notice] = "You're logged out!"
    session[:authorized] = false
    redirect_to root_path
  end
  
  def admin
  end
end
