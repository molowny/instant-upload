class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      format.html do
        if session[:user_avatar]
          tmp_file = InstantUpload::Upload.find(session[:user_avatar])
          @user.avatar = tmp_file.file
        end

        if @user.save
          session.delete(:user_avatar)
          redirect_to @user, notice: 'User was successfully created.'
        else
          render action: 'new'
        end
      end

      format.json do
        tmp_file = InstantUpload::Upload.new
        tmp_file.file = @user.avatar
        tmp_file.save

        session[:user_avatar] = tmp_file.id

        render json: { image: tmp_file.file.url }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :avatar)
    end
end
