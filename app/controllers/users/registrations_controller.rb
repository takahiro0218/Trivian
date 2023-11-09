class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_guest, only: [:destroy, :update]

  def check_guest
    if resource.email == "guest@example.com"
      redirect_to root_path, notice: "ゲストユーザーは編集・削除できません"
    end
  end

end
