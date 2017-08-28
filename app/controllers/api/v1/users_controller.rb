class Api::V1::UsersController < ApplicationController
	respond_to :json

	# GET /v1/users
	def index
		if params[:query]
			@users = User.search(params[:query]).order("created_at DESC")
		else
			@users = User.all.order('created_at DESC')
		end

		respond_with @users.as_json(only: [:email, :phone_number, :full_name, :key, :account_key, :metadata])
	end

	# POST /v1/users
	def create
		@user = User.new(user_params)

		if @user.save
			respond_with @user.as_json(only: [:email, :phone_number, :full_name, :key, :account_key, :metadata]),
									 status: '201 Created', location: nil
		else
			respond_to do |format|
				format.json { render :json => { "errors" => @user.errors },
														 :status => :unprocessable_entity }
			end
		end
	end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
		params.require(:user).permit(:email, :phone_number, :full_name, :password_digest, :metadata)
    end
end
