class AccountsController < ApplicationController
  skip_before_filter :check_account_permission, :only => [:new, :create]
  before_action :set_account, only: [:edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html { render layout: "account" }
      format.json {render json: @accounts}
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = params[:id] == '0' ? @current_account :  Account.find(params[:id])
    unless @account.nil?
      respond_to do |format|
        format.html
        format.json { render json: @account }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: { }, status: :accepted }
      end
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.password ||= params[:password]
    @account.password_confirmation = @account.password
    #Đăng ký mới Merchant (có thể thau đổi về sao)
    if current_account == nil
      @account.account_type = 3 #1 tức là Merchant, sẽ chuyển thành enum sau
      @account.parent_id = 0
      @account.headquater = 0

    #Tạo tài khản con cho Gera khi đã đăng nhập bằng tài khoản chính Gera
    elsif current_account.account_type == 1
      @account.account_type = 2
      @account.parent_id = current_account.id
      @account.headquater = current_account.id
    #Tạo tài khản con cho Agency khi đã đăng nhập bằng tài khoản chính Agency
    elsif current_account.account_type == 3
      @account.account_type = 4
      @account.parent_id = current_account.id
      @account.headquater = current_account.id
    #Tạo tài khản con cho Merchant khi đã đăng nhập bằng tài khoản chính Merchant
    elsif current_account.account_type == 5
      @account.account_type = 6
      @account.parent_id = current_account.id
      @account.headquater = current_account.id

    elsif current_account.account_type == 2
      @account.account_type = 2
      @account.parent_id = current_account.id
      @account.headquater = current_account.headquater
    elsif current_account.account_type == 4
      @account.account_type = 4
      @account.parent_id = current_account.id
      @account.headquater = current_account.headquater
    elsif current_account.account_type == 6
      @account.account_type = 6
      @account.parent_id = current_account.id
      @account.headquater = current_account.headquater

    end

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Gera account was successfully created.'}
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Gera account was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:display_name, :login_name, :email, :phone, :status, :password)
    end

end
