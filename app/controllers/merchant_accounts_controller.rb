class MerchantAccountsController < MerchantApplicationController
  before_action :set_merchant_account, only: [:edit, :update, :destroy]

  # GET /merchant_accounts
  # GET /merchant_accounts.json
  def index
    @merchant_accounts = MerchantAccount.all
    respond_to do |format|
      format.html { render layout: "account" }
      format.json { render :json => @merchant_accounts }
    end
  end

  def current_user
    render json: current_account.find_merchant_account
  end

  def current_sales
    @sales = Merchant.find_branch_sales(current_merchant_account.branch_id)
    render json: @sales, :root => false
  end

  # GET /merchant_accounts/1
  # GET /merchant_accounts/1.json
  def show
    if params[:id] == '0'
      @merchant_account = MerchantAccount.find(@current_account.id)
    else
      @merchant_account = MerchantAccount.find(params[:id])
    end

    if @merchant_account.nil?
      respond_to do |format|
        format.html
        format.json { render json: {}, status: :accepted }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @merchant_account }
      end
    end
  end

  # GET /merchant_accounts/new
  def new
    @merchant_account = MerchantAccount.new
  end

  # GET /merchant_accounts/1/edit
  def edit
  end

  # POST /merchant_accounts
  # POST /merchant_accounts.json
  def create
    @merchant_account = MerchantAccount.new(merchant_account_params)

    respond_to do |format|
      if @merchant_account.save
        format.html { redirect_to @merchant_account, notice: 'Merchant account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @merchant_account }
      else
        format.html { render action: 'new' }
        format.json { render json: @merchant_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchant_accounts/1
  # PATCH/PUT /merchant_accounts/1.json
  def update
    respond_to do |format|
      if @merchant_account.update(merchant_account_params)
        format.html { redirect_to @merchant_account, notice: 'Merchant account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @merchant_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchant_accounts/1
  # DELETE /merchant_accounts/1.json
  def destroy
    @merchant_account.destroy
    respond_to do |format|
      format.html { redirect_to merchant_accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_account
      @merchant_account = MerchantAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_account_params
      params.require(:merchant_account).permit(:account_id, :merchant_id, :branch_id, :current_warehouse_id, :role_id)
    end
end