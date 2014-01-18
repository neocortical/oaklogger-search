class SearchController < ApplicationController
  
  def home
    @search = Search.new
  end
  
  def search
    @search = Search.new(search_params)
    
    @posts = Post.do_search(@search)
  end
  
  
  private 
  
  def search_params
    params.require(:search).permit(:q)
  end
end
