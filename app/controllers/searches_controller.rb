class SearchesController < ApplicationController
  
  def search
    @categories = Category.all
  end
  
  def search_result
    @word = params[:word]
    @range = params[:range]
    if @range == "ユーザー名"
      @results = User.partial_search(@word)
    else
      @results = Post.partial_search(@word)
    end
  end
  
end
