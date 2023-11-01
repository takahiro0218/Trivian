class SearchesController < ApplicationController
  
  def search
    @categories = Category.all
  end
  
  def search_result
    @word = params[:word]
    @range = params[:range]
    if @range == "ユーザー名"
      @results = User.partial_search(@word).page(params[:page]).per(20)
    else
      @results = Post.partial_search(@word).page(params[:page]).per(8)
    end
  end
  
end
