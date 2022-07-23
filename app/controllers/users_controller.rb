class UsersController < ApplicationController
  before_action :authorize, only: %i[home] 
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    #render json: @users, only: [:name]
    render json: @users
    

    
    #@p = {da: "yes"}
    #render json: [{unu: 1}]
  end
  def home
    @users = User.all
    render json: @users, only: [:name]
    #render json: @users
  end  

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token({user_id: @user.id})  


      render json: {user: @user, token: token}, status: :ok

    else
      render json: {error: "Invalid username or password"}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :ok
    else
      render json: {error: "Invalid username or password"}, status: :unprocessable_entity  
    end    
  end  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
