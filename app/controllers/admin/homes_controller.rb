class Admin::HomesController < ApplicationController
  def top
    @user = User.page(params[:page]).per(30)
  end
end
