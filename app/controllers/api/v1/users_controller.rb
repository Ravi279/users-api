class Api::V1::UsersController < ApplicationController
	respond_to :json

	# GET /v1/users
	def index
		if params[:query]
			@users = User.search(params[:query]).order("created_at DESC")
		else
			@users = User.all.order('created_at DESC')
		end

		respond_with @users
	end

	# POST /v1/users
	def create
		@user = User.new(user_params)

		if @user.save
			respond_with @user, status: '201 Created', location: nil
		else
			respond_with @user.errors, status: '422 Unprocessable Entity'
		end
	end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
		params.require(:user).permit(:email, :phone_number, :full_name, :password_digest, :metadata)
    end
end
