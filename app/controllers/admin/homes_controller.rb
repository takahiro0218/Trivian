class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @user = User.page(params[:page]).per(30)
  end
end
