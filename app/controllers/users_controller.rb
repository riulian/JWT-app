class UsersController < ApplicationController
  before_action :authorize, only: %i[home create] 
  before_action :set_user, only: %i[ show update destroy ]
  
  # GET /users
  def index
    @users = User.all
    @user=@users.find(7)
    render json:JSON.pretty_generate( @users.as_json(:include => { :books => { :only => [:id,:title] }},only: [:id , :name]))
   
  end
  def home
    @users = User.all
    render json: @users, only: [:name]
    #render json: @users
  end  
def nicolas1
    h={}
    #User.all.each do |emp|
    #value=[]
    #emp.books.each { |addr|  value.push(addr.title)  }
    #h[emp.name]=value
    
    #end
    #render json: JSON.pretty_generate(h)


  #User.all.each do |emp|
   #emp.books.each { |addr| puts (addr.title)  } #8+1 querry
   #end
   #User.joins(:books).all.each do |emp|
    #emp.books.each { |addr| puts (addr.title) }  #1+16 querry
   #end
   #User.includes(:books).all.each do |emp|
    #emp.books.each { |addr| puts (addr.title) }  #1+1 querry
   #end   
   #User.joins(:books).includes(:books).all.each do |emp| # 1 Querry
    #emp.books.each { |addr| puts(addr.title) }
   #end
   ################ 
   
   #@u=User.joins(:books).includes(:books).all.each do |emp| #asta e cea mai tare varianta
     value=[]
   # emp.books.each { |addr| h[emp[:name]]=value.push(addr.title) }
   #end
   
   #render json: JSON.pretty_generate(h)
   #####################
   #render json: (User.joins(:books).includes(:books).all.each do |emp| # 1 Querry
    #emp.books.each { |addr| puts(addr.title) }
   #end).to_json
   #render json: JSON.pretty_generate(@u.to_json)
   ################
   render json: (User.includes(:books).all.each do |emp|
    value.push(emp.name)
    emp.books.each { |addr| value.push(addr.title),  emp[:name]=value }
    value=[]
    #1+1 querry
   end ).as_json( :only => [:id, :name] )
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
      token = encode_token({user_id: @user.id, da: 'da' })
      
     
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
