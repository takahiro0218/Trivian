class Admin::CategoriesController < ApplicationController
  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def update
    @categories = Category.all
    @categories_values = params[:category].values
    @categories.zip(@categories_values) do |category, value|
      category.update(name: value)
    end
    redirect_to admin_categories_path
    flash[:notice] = "変更内容を保存しました"

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "ジャンルを追加しました"
      redirect_to request.referer
    else
      @categories = Category.all
      render :index
    end
  end


  private

  def category_params
    params.require(:category).permit(:name, :id)
  end

end
