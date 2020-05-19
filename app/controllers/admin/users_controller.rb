class Admin::UsersController < AdminController
  def index
    @users = User.with_attached_avatar.includes(doctor: [:specialists, :treatments]).order(:id)
    render json: { status: 500, errors: ['no users found'] } unless @users
  end

  def update_status
    @user = User.find_by(id: params[:id])
    @user.update_attribute(:active, params[:active])
  end
end
