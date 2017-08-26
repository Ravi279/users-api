class UsersController < ApiController
  # GET /v1/users
  def index
	if params[:query]
		@users = User.search(params[:query]).order("created_at DESC")
	else
		@users = User.all.order('created_at DESC')
	end

    render json: @users
  end

  # POST /v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  #
  # # PATCH/PUT /users/1
  # def update
  #   if @user.update(user_params)
  #     render json: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end
  #
  # # DELETE /users/1
  # def destroy
  #   @user.destroy
  # end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:id, :email, :phone_number, :full_name, :password, :key, :account_key, :metadata)
    end
end
